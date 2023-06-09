# NAME

classify.pl - Classify all sounds in the CHARCOD table into either vowel
or consonant categories.

# SYNOPSIS

    classify.pl < CHARCOD.txt > output.txt

# DESCRIPTION

The input must be the CHARCOD table from UPSID, after it has been run
through the `denul.pl` script.

The output is a report that lists all sounds with their vowel or
consonant class, the code name, and the full name of the sound, sorted
first by class, then by the code name.

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
