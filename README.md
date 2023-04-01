# CVRatio

Tabulate the consonant to vowel phoneme ratios of languages in the UCLA Phonological Segment Inventory Database (UPSID).

## Data sources

The data files for this project can be found in the UPSID-PC distribution, which is available for download [here](http://phonetics.linguistics.ucla.edu/sales/software.htm):

    http://phonetics.linguistics.ucla.edu/sales/software.htm

Within the ZIP file for the program, the data files are:

- `CHARCOD.STR`
- `FEATS.STR`
- `LANGS.STR`
- `SEGS.STR`

The subfolders `UPSID2` `UPSID3` and `UPSID4` contain reference files, with one file per language.  The file names in those directories include the numeric language ID code that is used within UPSID.  The files are plain-text files that identify the language and reference the sources that were used to derive the phonological data for the language that appears within UPSID.

A simple web interface to the UPSID data is available [here](http://web.phonetik.uni-frankfurt.de/upsid.html):

    http://web.phonetik.uni-frankfurt.de/upsid.html

This web interface is not required for this CVRatio project, but a link is provided here for convenience to the reader.

To generate the filtered list of languages, you will also need a table of ISO-639-1 language codes.  You can get the table from the [following website](https://www.loc.gov/standards/iso639-2/):

    https://www.loc.gov/standards/iso639-2/

This is the website for ISO-639-2, but ISO-639-1 is a subset of ISO-639-2 and so its data is included within.  Follow the [ISO 639-2 Code List](https://www.loc.gov/standards/iso639-2/langhome.html) link, and then the [Code list for downloading](https://www.loc.gov/standards/iso639-2/ascii_8bits.html) link.  You want the [Character encoding in UTF-8](https://www.loc.gov/standards/iso639-2/ISO-639-2_utf-8.txt) version.

The result should be a plain-text file with records that use `|` as a field separator, where each record has ISO 639-2 three-letter codes, an ISO 639-1 two-letter code if available, and the language names in both English and French.

## Results

The complete tabulation of UPSID languages according to number of consonant phonemes, number of vowel phonemes, and ratio of consonants to vowels is given in `results-full.txt`.  The records are sorted in descending order of the ratio of consonants to vowels.

`results-subset.txt` is a subset of `results-full.txt` that only includes languages that have a two-letter language code in ISO-639-1.  This filters many rare languages out of the UPSID data, since data for rare languages is often unreliable.

## Recreating the results

The scripts used to generate the results are in the `src` subdirectory of this project.  See the `README.md` file in that subdirectory for further information.

The intermediate data files used to generate the results are in the `data` subdirectory of this project.  See the `README.md` file in that subdirectory for instructions how to generate the intermediate data files and how to generate the `results-full.txt` and `results-subset.txt` data files.
