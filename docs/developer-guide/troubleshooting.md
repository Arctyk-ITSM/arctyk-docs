## Web server does not load website

This can happen for a number or reasons. The most common reason is that the code base has error or errors and is preventing the website from being served. 

1. Check Docker logs for errors:
   
   ```bash
   docker compose logs -f
   ```

2. Correct any errors you find.
3. Stop the container: `docker compose down`
4. Rebuild and restart the container: `docker compoes up -d --build`

!!! tip
To stop or exit Docker logs, use `CNTRL + C`


---

## Common Linting Errors
These linting errors may or may not break the build. The two main linters are **Pylance** and **DjLint**. 

- **Expected whitespace**
	- **Explanation:** Common error on Django blocks.
	- **Error:**
	- **Solution**: Add whitespace between the block tag text and brackets.
- **Expected 2 blank lines**: 
	- **Explanation:** Pylance expects two blank lines between functions.
	- **Error:** `expected 2 blank lines, found 1`
	- **Solution:** Add another blank line above the indicated line and resave file.
- **Trailing whitespace**
	- **Explanation:** There is whitespace added to the end of the line.
	- **Error:**
	- **Solution**: Remove any trailing whitespace and resave file.