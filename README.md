poor man's clang autocomplete
=============================

For any text editor out there. Written primarily for C language.

**Basic usage**:

Open `main.c` with your favorite text editor, type `prin` and add ` character to its end, like so:

```c
#include <stdio.h>

int main()
{
  prin`
  
  return 0;
}
```

Save the file.

Now open a terminal window and type:

```bash
watch -n 0.1 "./complete.sh main.c"
```

You should see:

```
int printf(const char *restrict __format, ...)
```

That's it! Type ` character at the end of any code you want to complete, save the file and see the result.

**License**: Public domain

**Reference**: http://clang.llvm.org/doxygen/group__CINDEX__CODE__COMPLET.html (Function Documentation)
