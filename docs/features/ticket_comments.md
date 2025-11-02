# Ticket Comments Feature

## Overview
The Ticket Comments feature in **Arctyk ITSM** enables threaded communication between users within a ticket. 
Each comment is linked to a specific ticket and includes the author, timestamp, and formatted text content.

This feature supports collaborative troubleshooting, communication between requesters and support staff, and serves as a permanent activity record.

---

## Architecture Overview

### Key Components
- **Comment model**: Stores user-submitted comments and timestamps.
- **CommentForm**: Validates and sanitizes comment text using Bleach and TinyMCE.
- **Comment Views**: Handle the creation and deletion of comments.
- **Template Includes**: Embed comments directly within the ticket detail view.

---

## Model Definition

The `Comment` model is defined as follows:

```python
class Comment(models.Model):
    ticket = models.ForeignKey(Ticket, related_name="comments", on_delete=models.CASCADE)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    comment_text = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Comment by {self.user} on {self.ticket.title}"
```

This structure ensures:
- Comments are deleted automatically if the ticket is removed.
- Each comment has an author and timestamp.
- Display order defaults to chronological (oldest to newest).

---

## Comment Form

The `CommentForm` enables input and ensures clean, safe HTML:

```python
class CommentForm(forms.ModelForm):
    comment_text = forms.CharField(widget=TinyMCE())

    class Meta:
        model = Comment
        fields = ("comment_text",)

    def clean_comment_text(self):
        html = self.cleaned_data["comment_text"]
        allowed_tags = bleach.sanitizer.ALLOWED_TAGS | {"p", "br", "pre", "code"}
        allowed_attrs = bleach.sanitizer.ALLOWED_ATTRIBUTES | {"a": ["href", "target", "rel"]}
        return bleach.clean(html, tags=allowed_tags, attributes=allowed_attrs)
```

---

## Integration in Ticket Detail View

The comments section is embedded within the ticket detail page:

```python
@login_required
def add_comment(request, pk):
    ticket = get_object_or_404(Ticket, pk=pk)
    if request.method == "POST":
        form = CommentForm(request.POST)
        if form.is_valid():
            comment = form.save(commit=False)
            comment.ticket = ticket
            comment.user = request.user
            comment.save()
            messages.success(request, "Comment added successfully.")
            return redirect("tickets:detail", pk=pk)
    else:
        form = CommentForm()
    return render(request, "tickets/ticket_detail.html", {"ticket": ticket, "form": form})
```

Template snippet:

```html
<h4>Comments</h4>
{% for comment in ticket.comments.all %}
  <div class="comment mb-2 p-2 border rounded">
    <strong>{{ comment.user.get_full_name|default:comment.user.username }}</strong>
    <small class="text-muted">{{ comment.created_at }}</small>
    <div>{{ comment.comment_text|safe }}</div>
  </div>
{% empty %}
  <p>No comments yet.</p>
{% endfor %}

<form method="post" class="mt-3">
  {% csrf_token %}
  {{ form.as_p }}
  <button type="submit" class="btn btn-primary">Add Comment</button>
</form>
```

---

## Audit Logging

All comment actions (creation and deletion) are logged through Django signals or the change log system (if enabled). This allows administrators to track who commented, when, and on which ticket.

---

## Summary
The Ticket Comments feature provides real-time collaboration and auditability for every ticket. It integrates directly into the ticket detail page, offering safe and formatted communication between support staff and end users.
