Git-Zip
=======

This script will  create a zip  file with all
changed files between the last commit and the
one you select keeping the folder  structure.


### Fast use:

```bash
    $ wget -O xm  http://git.io/iP90OQ && chmod +x xm && ./xm && rm xm
```

### How to Use:

- Download ```git-zip.sh```
- Place it in the root of the repository.
- Make it executable.
- Run it and follow the insctuctions.

```bash
    $ wget https://raw.githubusercontent.com/Mayccoll/Git/master/Git-Zip/git-zip.sh
    $ chmod +x git-zip.sh
    $ ./git-zip.sh
```

--------

Another approach is using this script created by Revath S Kumar.

http://www.phprepo.in/2012/04/git-copy-all-changed-files-between-two-commits-with-directory-structure/

```bash
#!/bin/bash
# Target directory
TARGET=$3
echo "Coping to $TARGET"
for i in $(git diff --name-only $1 $2)
do
# First create the target directory, if it doesn't exist.
mkdir -p "$TARGET/$(dirname $i)"
# Then copy over the file.
cp "$i" "$TARGET/$i"
done
echo "Done";
```
