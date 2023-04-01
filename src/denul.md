# NAME

denul.pl - Convert nul characters to Unicode interpunct sign.

# SYNOPSIS

    denul.pl < input.bin > output.txt

# DESCRIPTION

Read the whole input as a raw binary file into memory.  Check that only
US-ASCII printing characters \[0x20, 0x7e\] are used, as well as the nul
character 0x00 and CR and LF line breaks.  The output will be UTF-8,
with all nul characters converted to U+00B7, which is the interpunct.

# AUTHOR

Noah Johnson, `noah.johnson@loupmail.com`

# COPYRIGHT AND LICENSE

Copyright (C) 2023 Multimedia Data Technology Inc.

MIT License:

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files
(the "Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
