poor man's clang autocomplete
=============================

For any text editor out there. Supports both C and C++.

<img src="https://i.imgur.com/Go6E0f0.gif" width="90%">

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
watch -cn 0.1 "./complete.sh main.c"
```

You should see:

```c
int printf(const char *restrict __format, ...)
```

That's it! Type ` character at the end of any code you want to complete, save the file and see the result.

**License**: Public domain

**Examples**: https://github.com/llvm-mirror/clang/tree/release_37/test/CodeCompletion

**Reference**: http://clang.llvm.org/doxygen/group__CINDEX__CODE__COMPLET.html (Function Documentation)
