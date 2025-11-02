# Ticket Creation Feature

## Overview
The Ticket Creation feature in **Arctyk ITSM** allows users to submit and manage tickets through the web interface, API, or automated workflows. 
Tickets serve as the primary unit of work in the IT Service Management system, representing issues, requests, or tasks reported by users.

This feature is powered by Django models, forms, and Celery for background operations such as notifications and automation triggers.

---

## Architecture Overview

### Key Components
- **Ticket model**: Stores all core data fields related to a ticket.
- **TicketForm**: Manages user input and validation for creating new tickets.
- **Views and Templates**: Handle the frontend interaction for creating and listing tickets.
- **Signals**: Trigger background notifications or workflow automations when tickets are created.

### Typical Workflow
1. A user navigates to the **“Create Ticket”** page.
2. The user fills out the form fields such as title, description, priority, and category.
3. The form validates and saves the ticket to the database.
4. The system assigns a unique `ticket_number` automatically.
5. Background processes (Celery) may send notifications or create audit entries.
6. The ticket appears in the user's ticket list and is available for updates or comments.

---

## Model Definition

The `Ticket` model defines the core schema for ticket storage:

```python
class Ticket(models.Model):
    ticket_number = models.PositiveIntegerField(unique=True, null=True, blank=True)
    title = models.CharField(max_length=255)
    description = models.TextField()
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default="new")
    priority = models.CharField(max_length=10, choices=PRIORITY_CHOICES, default="medium")
    category = models.CharField(max_length=50, choices=CATEGORY_CHOICES, default="task")
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    requester = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name="requested_tickets")
    project = models.ForeignKey("projects.Project", on_delete=models.SET_NULL, null=True, blank=True, related_name="tickets")
```

---

## Ticket Form

The `TicketForm` provides the primary interface for user submissions:

```python
class TicketForm(forms.ModelForm):
    description = forms.CharField(widget=TinyMCE())
    tags = TagField(required=False)
    ...
```

This form:
- Uses **TinyMCE** for rich text editing.
- Sanitizes HTML using **Bleach** to prevent XSS.
- Automatically pre-fills date/time fields such as `next_occurrence` for recurring tickets.
- Enforces validation such as ensuring due dates and recurrence intervals are valid.

---

## Validation and Auto-numbering

Each ticket is automatically assigned a sequential `ticket_number` using:

```python
if not self.ticket_number:
    max_number = Ticket.objects.aggregate(models.Max("ticket_number"))["ticket_number__max"] or 0
    self.ticket_number = max_number + 1
```

Validation logic ensures that:
- Required fields are populated.
- Invalid recurrence or due date combinations are rejected.
- The ticket is associated with a valid user if created via the UI.

---

## Views and Templates

The core view for ticket creation:

```python
@login_required
def create_ticket(request):
    if request.method == "POST":
        form = TicketForm(request.POST)
        if form.is_valid():
            ticket = form.save(commit=False)
            ticket.requester = request.user
            ticket.save()
            messages.success(request, f"Ticket #{ticket.ticket_number} created successfully.")
            return redirect("tickets:detail", pk=ticket.pk)
    else:
        form = TicketForm()
    return render(request, "tickets/create_ticket.html", {"form": form})
```

Template example: `templates/tickets/create_ticket.html`

```html
<form method="post">
  {% csrf_token %}
  {{ form.as_p }}
  <button type="submit" class="btn btn-primary">Create Ticket</button>
</form>
```

---

## API and Automation

Developers can create tickets programmatically using Django’s ORM or the REST API (if enabled):

```python
from tickets.models import Ticket
from django.contrib.auth.models import User

user = User.objects.get(username="admin")
Ticket.objects.create(
    title="Server Down",
    description="The production web server is not responding.",
    priority="high",
    requester=user,
)
```

---

## Summary
The Ticket Creation feature is a core part of Arctyk ITSM, providing a robust interface for creating, validating, and storing tickets across the system. It integrates tightly with the commenting system, recurrence scheduler, and automation pipelines for a complete ITSM workflow.
