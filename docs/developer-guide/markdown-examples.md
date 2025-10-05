# Markdown Examples (Visual Reference)

This page provides live examples of how Markdown syntax renders in the Arctyk Docs site.  

Use it as a quick reference when writing or reviewing documentation.

!!! info "Quick Links"
    - [Headings](#headings)
    - [Inline Formatting](#inline-formatting)
    - [Lists](#lists)
    - [Blockquotes](#blockquotes)
    - [Code Blocks](#code-blocks)
    - [Nested Code Fences](#nested-code-fences)
    - [Escaping Markdown Characters](#escaping-markdown-characters)
    - [Tables](#tables)
    - [Tables with Escaped Markdown](#tables-with-escaped-markdown)
    - [Admonitions](#admonitions)
    - [Collapsible Admonitions](#collapsible-admonitions)
    - [HTML Entities](#html-entities)
    - [Combining Markdown Elements](#combining-markdown-elements)

---

## Headings

### Example Markdown
```markdown
# H1 Heading
## H2 Heading
### H3 Heading
#### H4 Heading
```

### Output
# H1 Heading
## H2 Heading
### H3 Heading
#### H4 Heading

---

## Inline Formatting

### Example Markdown
```markdown
**Bold**  
_Italic_  
`Inline code`  
~~Strikethrough~~  
[Link text](https://arctyk.io)
```

### Output
**Bold**  
_Italic_  
`Inline code`  
~~Strikethrough~~  
[Link text](https://arctyk.io)

---

## Lists

### Example Markdown
```markdown
1. First step
2. Second step
   - Sub-step A
   - Sub-step B
3. Third step
```

### Output
1. First step  
2. Second step  
   - Sub-step A  
   - Sub-step B  
3. Third step

---

## Blockquotes

### Example Markdown
```markdown
> This is a standard blockquote.
>
> It can include **bold text**, _italics_, and even `inline code`.
```

### Output
> This is a standard blockquote.
>
> It can include **bold text**, _italics_, and even `inline code`.

---

## Code Blocks

### Example Markdown
```markdown
```bash
docker compose up -d
```
```

### Output
```bash
docker compose up -d
```

---

## Nested Code Fences

When showing Markdown examples that already contain code blocks, you must nest backticks properly.  
The outer fence must always have more backticks than the inner one.

### Example Markdown
``````markdown
````markdown
```bash
docker compose up -d
```
````
``````

### Output
````markdown
```bash
docker compose up -d
```
````

---

## Escaping Markdown Characters

### Example Markdown
```markdown
\*escaped asterisk\*  
\_escaped underscore\_  
\#escaped heading\#  
\|escaped pipe\|  
\`escaped backtick\`
```

### Output
\*escaped asterisk\*  
\_escaped underscore\_  
\#escaped heading\#  
\|escaped pipe\|  
\`escaped backtick\`

---

## Tables

### Example Markdown
```markdown
| Setting | Description | Example |
|----------|--------------|----------|
| `DEBUG` | Enables debug mode | `False` |
| `DB_PORT` | Database port | `5433` |
| `TIME_ZONE` | Django timezone | `America/Toronto` |
```

### Output
| Setting | Description | Example |
|----------|--------------|----------|
| `DEBUG` | Enables debug mode | `False` |
| `DB_PORT` | Database port | `5433` |
| `TIME_ZONE` | Django timezone | `America/Toronto` |

---

## Tables with Escaped Markdown

### Example Markdown
```markdown
| Symbol | Escaped Example | Renders As |
|---------|-----------------|------------|
| `*` | `\*bold\*` | \*bold\* |
| `_` | `\_italic\_` | \_italic\_ |
| `#` | `\# heading` | \# heading |
| `` ` `` | `` \`code\` `` | \`code\` |
| `|` | `\| pipe \|` | \| pipe \| |
```

### Output
| Symbol | Escaped Example | Renders As |
|---------|-----------------|------------|
| `*` | `\*bold\*` | \*bold\* |
| `_` | `\_italic\_` | \_italic\_ |
| `#` | `\# heading` | \# heading |
| `` ` `` | `` \`code\` `` | \`code\` |
| `|` | `\| pipe \|` | \| pipe \| |

---

## Admonitions

### Example Markdown
```markdown
!!! note
    This is a general note.

!!! tip "Quick Tip"
    Use `docker compose up -d --build` to rebuild containers.

!!! warning "Caution"
    Never commit your `.env` file to Git.
```

### Output
!!! note
    This is a general note.

!!! tip "Quick Tip"
    Use `docker compose up -d --build` to rebuild containers.

!!! warning "Caution"
    Never commit your `.env` file to Git.

---

## Collapsible Admonitions

### Example Markdown
```markdown
??? info "Show example"
    ```yaml
    version: "3.9"
    services:
      web:
        build: .
    ```
```

### Output
??? info "Show example"
    ```yaml
    version: "3.9"
    services:
      web:
        build: .
    ```

---

## HTML Entities

### Example Markdown
```markdown
| Character | HTML Entity | Output |
|------------|--------------|---------|
| Backtick | `&#96;` | &#96; |
| Less than | `&lt;` | &lt; |
| Greater than | `&gt;` | &gt; |
| Ampersand | `&amp;` | &amp; |
```

### Output
| Character | HTML Entity | Output |
|------------|--------------|---------|
| Backtick | `&#96;` | &#96; |
| Less than | `&lt;` | &lt; |
| Greater than | `&gt;` | &gt; |
| Ampersand | `&amp;` | &amp; |

---

## Combining Markdown Elements

### Example Markdown
```markdown
!!! example "Combining Elements"
    1. Run `docker compose up -d`
    2. Open [localhost:8000](http://localhost:8000)
    3. Verify the containers are running:
        ```bash
        docker ps
        ```
```

### Output
!!! example "Combining Elements"
    1. Run `docker compose up -d`
    2. Open [localhost:8000](http://localhost:8000)
    3. Verify the containers are running:
        ```bash
        docker ps
        ```

---

## Summary

| Section | Demonstrates |
|----------|--------------|
| Headings | Heading styles |
| Inline Formatting | Bold, italics, links |
| Lists | Ordered and unordered lists |
| Blockquotes | Indented callouts |
| Code Blocks | Syntax highlighting |
| Nested Code Fences | Showing Markdown inside Markdown |
| Escaping Markdown | Literal formatting characters |
| Tables | Structured data |
| Tables with Escaped Markdown | Markdown inside tables |
| Admonitions | Tips, notes, and warnings |
| Collapsible Admonitions | Expandable content |
| HTML Entities | Character references |
| Combining Markdown Elements | Complex formatting examples |
