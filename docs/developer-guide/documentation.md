# Arctyk ITSM Documentation Style Guide

This guide defines the writing, formatting, and Markdown conventions for the Arctyk ITSM documentation.
Following these standards ensures all docs are clear, consistent, and professional — across every module and version.

## Writing Style

**Tone:**

- Professional, clear, and concise
- Neutral and helpful (avoid jargon and slang)
- Use second person (“you”) when addressing the reader
- Use active voice whenever possible

**Examples:**

- “Run the command to start the container.”
- “The container can be started by running the command.”

## Document Structure
Each page should follow this structure:

```markdown
# Title (H1)

Short one-sentence summary.

---

## Section (H2)
Explanation of a concept or task.

### Subsection (H3)
Details or examples.

!!! tip
    Use callouts for helpful advice or best practices.

---
```
**Best Practices:**

- Use one **H1** (#) per page (the page title)
- Start each section with a brief overview sentence
- Use **H2** (##) for major sections, and **H3** (###) for subsections
- Separate major sections with horizontal rules (---)

## Admonitions (Tips, Notes, Warnings)

Use **admonitions** (MkDocs Material feature) to highlight key points.

**Examples:**

```markdown
!!! note
    This is a general note for extra context.

!!! tip "Pro Tip"
    You can rebuild the stack using `docker compose up -d --build`.

!!! warning "Be Careful!"
    Never commit your `.env` file to version control.

!!! success "Deployment Complete"
    Your container is running successfully at `http://127.0.0.1:8000`.
```
**Output:**

!!! note
    This is a general note for extra context.

!!! tip "Pro Tip"
    You can rebuild the stack using docker compose up -d --build.

!!! warning "Be Careful!"
    Never commit your `.env` file to version control.

!!! success "Deployment Complete"
    Your container is running successfully at `http://127.0.0.1:8000`.

## Code Blocks

### Code blocks
Use fenced code blocks with syntax highlighting:

````markdown
```bash
# Terminal / shell
docker compose up -d
```
````

````markdown
```python
# Python example
from django.conf import settings
print(settings.DEBUG)
```
````

````markdown
```yaml
# Docker Compose
version: "3.9"
services:
web:
    build: .
```
````
If you want to show an inline code example that contains backticks, simply use more backticks around it than the example itself.
 
### Inline code
Use backticks ``` `` ``` for commands, filenames, or variables.

**Example:**

Run python ``` `manage.py migrate` ``` to apply database changes.

### Showing Markdown Literals

When writing documentation about Markdown itself, you’ll sometimes want to show characters like backticks (\``), asterisks (*`), or code fences (```) without triggering Markdown formatting.

This section explains how to safely render those symbols in your Arctyk ITSM documentation.

#### Showing Code Fences (Triple Backticks)
`````markdown
````markdown
```bash
docker compose up -d
```
````
`````
#### Nested Code Fences

When showing Markdown examples that already contain code blocks, you must nest backtick fences correctly.
The outer fence must *always* have more backticks than the inner one. 

**Level 1 — Normal Code Block (3 backticks)**
````markdown
```bash
docker compose up -d
```
````
**Leve 1 Output:**

```bash
docker compose up -d
```
**Level 2 — Showing a Code Block (4 backticks)**
`````markdown
````markdown
```bash
docker compose up -d
```
````
`````
**Level 2 Output:**
````markdown
```bash
docker compose up -d
```
````
**Level 3 — Showing an Example of the Example (5 backticks)**
``````markdown
`````markdown
````markdown
```bash
docker compose up -d
```
````
`````
``````
**Level 3 Output:**
`````markdown
````markdown
```bash
docker compose up -d
```
````
`````

#### Showing Code Inside an Admonition

You can even nest these inside an admonition (like a Tip or Example block):

If you want to show a literal code block example like this:

````markdown
!!! example "Show Markdown Example"
    ````markdown
    ```bash
    docker compose up -d
    ```
    ````
````
**Output:**

!!! example "Show Markdown Example"
    markdown ```bash docker compose up -d ```

#### Inline Backticks
Here’s how to use `` `inline code` `` in Markdown.

#### Escaping Markdown Characters

If you need to show Markdown symbols (like *, |, #) as text, you can escape them with a backslash \:

| Symbol  | Escaped Form | Example Output   |         |
| ------- | ------------ | ---------------- | ------- |
| `*`     | `\*`         | *asterisks*      |         |
| `_`     | `\_`         | _underscores_    |         |
| `       | `            | `\|`             | |pipes| |
| `#`     | `\#`         | # heading symbol |         |
| `` ` `` | `` \` ``     | `backtick`       |         |

#### Using HTML Entities

As a fallback (useful inside tables or inline text), you can replace special characters with HTML entities:

| Character    | HTML Code | Output |
| ------------ | --------- | ------ |
| Backtick     | `&#96;`   | `      |
| Less than    | `&lt;`    | <      |
| Greater than | `&gt;`    | >      |
| Ampersand    | `&amp;`   | &      |

#### Tables Containing Literal Markdown

When writing Markdown tables that include Markdown symbols (like *, #, or backticks), you must escape those characters or use HTML entities to prevent Markdown from interpreting them.

**Example Table with Escaped Markdown:**

```markdown
| Symbol | Escaped Example | Renders As |
|---------|-----------------|------------|
| `*` | `\*bold\*` | \*bold\* |
| `_` | `\_italic\_` | \_italic\_ |
| `#` | `\# heading` | \# heading |
| `` ` `` | `` \`code\` `` | \`code\` |
| `|` | `\| pipe \|` | \| pipe \| |
```
**Example Table Output:**

| Symbol | Escaped Example | Renders As |
|---------|-----------------|------------|
| `*` | `\*bold\*` | \*bold\* |
| `_` | `\_italic\_` | \_italic\_ |
| `#` | `\# heading` | \# heading |
| `` ` `` | `` \`code\` `` | \`code\` |
| `|` | `\| pipe \|` | \| pipe \| |

#### Using HTML Entities in Tables

Sometimes escaping isn’t enough — for instance, when showing multiple backticks in one cell.
In those cases, use HTML entities instead of literal characters:

```markdown
| Description | Example |
|--------------|----------|
| Triple backticks | &#96;&#96;&#96;bash ... &#96;&#96;&#96; |
| Greater than symbol | &gt; Quote |
| Ampersand | &amp; |
```

**Example Output:**

| Description | Example |
|--------------|----------|
| Triple backticks | &#96;&#96;&#96;bash ... &#96;&#96;&#96; |
| Greater than symbol | &gt; Quote |
| Ampersand | &amp; |

!!! Tips for Markdown in Tables
    - Always wrap table contents in backticks or escape special symbols.
    - Avoid multi-line code blocks inside tables — instead, show examples below the table.
    - If Markdown syntax doesn’t render as expected, try using HTML equivalents (e.g. <code> or &#96;).

---

## Tables
Keep tables simple and aligned.
Use them for configuration summaries, variable lists, or comparisons.

````markdown
| Variable | Description | Example |
|-----------|-------------|----------|
| `DEBUG` | Enables or disables debug mode | `False` |
| `DB_PORT` | Database port number | `5433` |
| `TIME_ZONE` | Server timezone | `America/Toronto` |
````
**Output:**

| Variable    | Description                    | Example           |
| ----------- | ------------------------------ | ----------------- |
| `DEBUG`     | Enables or disables debug mode | `False`           |
| `DB_PORT`   | Database port number           | `5433`            |
| `TIME_ZONE` | Server timezone                | `America/Toronto` |

## Linking

### Internal Links

Link to other pages in the documentation using relative paths:

````markdown
See [Configuration](../getting-started/configuration.md) for environment setup.
````

### External Links

Use standard Markdown syntax:

````markdown
Learn more at [Django Documentation](https://docs.djangoproject.com/).
````

## Images & Diagrams

Place all images in `docs/assets/`.

````markdown
![Arctyk Architecture Diagram](../assets/architecture-diagram.png)
````

!!! Tip
    Use SVG or PNG for diagrams, and compress large images to < 500 KB.

## Lists and Steps

Use numbered lists for sequential steps, and bulleted lists for unordered details.

### Numbered Lists:
Numbered lists are often referred to as **ordered lists**. Best used for sequential steps.

**Example:**
Complete the following steps to install Arctyk ITSM docker:

````markdown
1. Clone the repository.
2. Copy the `.env.example` to `.env`.
3. Run `docker compose up -d` to start services.
````

**Output:**

1. Clone the repository.
2. Copy the `.env.example` to `.env`.
3. Run `docker compose up -d` to start services.

### Bulleted Lists
Bulleted lists are often referred to as **undordered lists**. Best used for listing details.

**Example:**
Things to remember when installing Arctyk ITSM

````markdown
- Ensure you have Docker installed before you proceed. 
- You should always clone the `dev branch` repository.
- Double-check that `.env` is added to `.gitignore`.
````

**Output:**

- Clone the repository.
- Copy the `.env.example` to `.env`.
- Run `docker compose up -d` to start services.

## Collapsible Sections

Use collapsible admonitions for optional or detailed content:

````markdown
??? info "Show full docker-compose.yml"
    ```yaml
    version: "3.9"
    services:
      web:
        build: .
    ```
````

**Output:**

??? info "Show full docker-compose.yml"
yaml version: "3.9" services: web: build: .

## Quick Formatting Reference
| Element | Syntax         | Example                           |
| ------- | -------------- | --------------------------------- |
| Bold    | `**text**`     | **Bold text**                     |
| Italic  | `_text_`       | *Italic text*                     |
| Code    | `` `text` ``   | `inline code`                     |
| Link    | `[label](url)` | [Visit Arctyk](https://arctyk.io) |
| Image   | `![alt](path)` | `![Logo](../assets/logo.svg)`     |
| Quote   | `> text`       | > Quoted block                    |
| Divider | `---`          | Horizontal line                   |

## Consistent Terminology
| Preferred Term | Avoid Using                         | Notes                                                        |
| -------------- | ----------------------------------- | ------------------------------------------------------------ |
| Arctyk ITSM    | Arctyk, ITSM system                 | Always use full name on first mention                        |
| Help Desk      | Helpdesk                            | Capitalize properly                                          |
| Ticket         | Issue, request                      | Consistent with UI terminology                               |
| Asset          | Device, hardware                    | Matches inventory module                                     |
| Docker Compose | Docker-Compose, docker compose file | Use official capitalization                                  |
| PostgreSQL     | Postgres                            | “PostgreSQL” in documentation, “Postgres” acceptable in code |

## Example Layout Template

Here’s the recommended page layout for new documentation pages:

````markdown
# Page Title

Short description of what this guide covers.

---

## 1. Overview
Brief explanation.

!!! tip
    Helpful context or summary of what’s next.

---

## 2. Steps

1. Step one
2. Step two
3. Step three

---

## 3. Example

```bash
docker compose exec web python manage.py migrate
```
````
## Next Steps

Installation Guide

Configuration Guide

### Final Notes

- Keep sentences short and easy to scan.  
- Avoid nested lists deeper than two levels.  
- Always include code fences for shell commands.  
- Keep headings concise and meaningful.