# Recurring Tickets Feature

## Overview
The recurring tickets system in **Arctyk ITSM** automates the creation of scheduled tickets using **Celery** and **django-celery-beat**. 
This functionality allows tickets to recur automatically on a defined schedule such as daily, weekly, or monthly.

The system ensures that each recurring ticket is logged, tracked, and audited through the `RecurringTicketRun` model, providing transparency and reliability in automation.

---

## Architecture Overview

### Components
- **Django Models**: Define ticket recurrence fields and store recurring ticket metadata.
- **Celery Worker**: Executes tasks such as ticket creation and recurrence processing.
- **Celery Beat**: Schedules recurring tasks using crontab-like rules.
- **Redis**: Serves as the message broker between Celery Beat and Workers.
- **Audit Logging**: The `RecurringTicketRun` model logs each recurring task execution with performance metrics.

### Workflow Summary

1. A user creates or edits a ticket and marks it as **recurring**.
2. The user specifies a recurrence interval (`daily`, `weekly`, `monthly`) and a `next_occurrence` date/time.
3. Celery Beat schedules the `process_recurring_tickets` task via `django_celery_beat`.
4. Celery Worker executes the task when the schedule triggers.
5. The system duplicates due recurring tickets and shifts their `next_occurrence` to the next scheduled date.
6. Each run is recorded in `RecurringTicketRun` for auditing.

---

## Implementation Details

### Ticket Model

The `Ticket` model includes fields that define recurrence settings:

```python
is_recurring = models.BooleanField(default=False)
recurrence_interval = models.CharField(
    max_length=20,
    choices=[("daily", "Daily"), ("weekly", "Weekly"), ("monthly", "Monthly")],
    blank=True,
    null=True,
)
recurrence_every = models.PositiveIntegerField(
    default=1,
    help_text="Number of intervals between each recurrence (e.g. every 2 weeks)",
)
next_occurrence = models.DateTimeField(blank=True, null=True)
```

The method `schedule_next_occurrence()` determines and updates the next due date based on the recurrence interval.

### Celery Task

The main Celery task is `process_recurring_tickets`, which performs the following steps:

1. Queries for all tickets where:
   - `is_recurring=True`
   - `next_occurrence <= now()`
   - `archived=False`
2. For each ticket found, duplicates it with the same metadata.
3. Updates the ticket's `next_occurrence` using its recurrence logic.
4. Logs the outcome in `RecurringTicketRun`.

```python
@shared_task
def process_recurring_tickets():
    now = timezone.now()
    due_tickets = Ticket.objects.filter(is_recurring=True, next_occurrence__lte=now, archived=False)
    for ticket in due_tickets:
        Ticket.objects.create(...)
        ticket.schedule_next_occurrence()
```

---

## Scheduling

### Configuration in Settings

The recurring ticket processor is scheduled via Celery Beat:

```python
from celery.schedules import crontab

CELERY_BEAT_SCHEDULE = {
    "process-recurring-tickets": {
        "task": "tickets.tasks.process_recurring_tickets",
        "schedule": crontab(minute="*/5"),  # Every 5 minutes
    },
}
```

Celery Beat reads this configuration and sends jobs to the worker through Redis.

---

## Audit Logging

Each Celery run creates a record in the `RecurringTicketRun` table, logging:

- Start time and finish time
- Total processed tickets
- Total created tickets
- Status (`success` or `error`)
- Duration in seconds

This allows administrators to track automation performance.

Example model:

```python
class RecurringTicketRun(models.Model):
    started_at = models.DateTimeField(auto_now_add=True)
    finished_at = models.DateTimeField(null=True, blank=True)
    total_processed = models.PositiveIntegerField(default=0)
    total_created = models.PositiveIntegerField(default=0)
    status = models.CharField(max_length=20, choices=[("success", "Success"), ("error", "Error")])
    duration_seconds = models.FloatField(default=0)
```

---

## Docker and Deployment

In Docker, Celery services must run alongside the Django web application:

```yaml
services:
  redis:
    image: redis:7

  worker:
    build: .
    entrypoint: ["/entrypoint.sh", "celery"]
    depends_on: [db, redis]
    restart: always

  beat:
    build: .
    entrypoint: ["/entrypoint.sh", "beat"]
    depends_on: [db, redis]
    restart: always
```

---

## Troubleshooting

| Issue | Possible Cause | Solution |
|-------|----------------|----------|
| No recurring tickets created | Beat not running or misconfigured | Ensure `beat` container is active and connected to Redis |
| Task not visible in logs | Worker not listening on the correct queue | Verify worker command includes `-Q celery` |
| Timezone mismatch | Incorrect timezone setting | Confirm `TIME_ZONE = "America/Toronto"` and `CELERY_TIMEZONE = TIME_ZONE` |
| Duplicate tickets not appearing | Recurrence logic skipped | Check if `next_occurrence` is in the past when testing |

---

## Developer Notes

- Always ensure Beat and Worker containers restart automatically with the application.
- To test the system manually, run:
  ```bash
  docker compose exec web python src/manage.py shell
  ```
  ```python
  from tickets.tasks import process_recurring_tickets
  process_recurring_tickets.delay()
  ```
- For visibility, use the **Recurring Ticket Health Dashboard** in Django Admin to view the latest status, duration, and number of tickets processed.

---

## Summary

The recurring ticket system is a modular automation feature in Arctyk ITSM that leverages Django, Celery, and Redis to generate scheduled tickets at consistent intervals. 
It provides complete transparency through audit logs and is fully containerized for reliable background processing.

