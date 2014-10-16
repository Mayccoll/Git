#!/bin/bash
rm ../run-test.sh
cp run-test.sh ../run-test.sh
cp ../run-test.sh run-test.sh
cp ../git-zip.sh git-zip.sh

# Reset color
RS="\e[0m"
# Basic Colors
BLACK="\e[0;30m"
RED="\e[0;31m"
GREEN="\e[0;32m"
YELLOW="\e[0;33m"
BLUE="\e[0;34m"
PURPLE="\e[0;35m"
CYAN="\e[0;36m"
WHITE="\e[0;37m"


SCRIPT_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
APLICATION=${PWD##*/}


rm .gitignore
touch .gitignore
echo run-test.sh >> .gitignore
echo +run-test.sh >> .gitignore
echo git-zip.sh >> .gitignore
echo test.sh >> .gitignore
echo *.zip >> .gitignore

git init
git config  user.email "you@example.com"
git config  user.name "Your Name"

git add .
git commit -m "init"


# 01 File add
echo -e "${CYAN} -# 01 File add- ${RS}"
touch file1.txt
git add .
git commit -m "# 01 File add"
./git-zip.sh
#mv "${APLICATION}"*.zip 01.zip

# 02 File mod
echo -e "${CYAN} -# 02 File mod- ${RS}"
echo "xxxxxxxx" >> file1.txt
git add .
git commit -m "# 02 File mod"
./git-zip.sh
#mv "${APLICATION}"*.zip 02.zip


# 03 File add + File mod
echo -e "${CYAN} -# 03 File add + File mod- ${RS}"
touch file2.txt
echo "xxxxxxxx" >> file1.txt
git add .
git commit -m "# 03 File add + File mod"
./git-zip.sh
#mv "${APLICATION}"*.zip 03.zip


# 04 Folder add - File add
echo -e "${CYAN} -# 04 Folder add - File add- ${RS}"
mkdir dir1
touch dir1/filedir1
git add .
git commit -m "# 04 Folder add - File add"
./git-zip.sh
#mv "${APLICATION}"*.zip 04.zip


# 05 Folder - File mod
echo -e "${CYAN} -# 05 Folder - File mod- ${RS}"
echo "xxxxxxxx" >> dir1/filedir1
git add .
git commit -m "# 05 Folder - File mod"
./git-zip.sh
#mv "${APLICATION}"*.zip 05.zip


# 06 Folder - File add + File mod
echo -e "${CYAN} -# 06 Folder - File add + File mod- ${RS}"
touch dir1/filedir2
echo "xxxxxxxx" >> dir1/filedir1
git add .
git commit -m "# 06 Folder - File add + File mod"
./git-zip.sh
#mv "${APLICATION}"*.zip 06.zip


# 07 Folder add - Sub Folder add - File add
echo -e "${CYAN} -# 07 Folder add - Sub Folder add - File add- ${RS}"
mkdir dir2
mkdir dir2/subfolder
touch dir2/subfolder/subfile
git add .
git commit -m "# 07 Folder add - Sub Folder add - File add"
./git-zip.sh
#mv "${APLICATION}"*.zip 07.zip


# 08 Folder - Sub Folder - File mod
echo -e "${CYAN} -# 08 Folder - Sub Folder - File mod- ${RS}"
echo "xxxxxxxx" >> dir2/subfolder/subfile
git add .
git commit -m "# 08 Folder - Sub Folder - File mod"
./git-zip.sh
#mv "${APLICATION}"*.zip 08.zip


# 9 Folder - Sub Folder - File Mod + File Add
echo -e "${CYAN} -# 9 Folder - Sub Folder - File Mod + File Add- ${RS}"
touch dir2/subfolder/subfile2
echo "xxxxxxxx" >> dir2/subfolder/subfile
git add .
git commit -m "# 9 Folder - Sub Folder - File Mod + File Add"
./git-zip.sh
#mv "${APLICATION}"*.zip 09.zip


# 10 Multiple file add 8
echo -e "${CYAN} -# 10 Multiple file add 8- ${RS}"
touch multi1
touch multi2
touch multi3
touch multi4
touch multi5
touch multi6
touch multi7
touch multi8
git add .
git commit -m "# 10 Multiple file add 8"
./git-zip.sh
#mv "${APLICATION}"*.zip 09.zip


# 11 Multiple file mod 8
echo -e "${CYAN} -# 12 Multiple file Add 2 + File mod 2- ${RS}"
echo "xxxxxxxx" >> multi1
echo "xxxxxxxx" >> multi2
echo "xxxxxxxx" >> multi3
echo "xxxxxxxx" >> multi4
echo "xxxxxxxx" >> multi5
echo "xxxxxxxx" >> multi6
echo "xxxxxxxx" >> multi7
echo "xxxxxxxx" >> multi8
git add .
git commit -m "# 11 Multiple file mod 8"
./git-zip.sh
#mv "${APLICATION}"*.zip 11.zip


# 12 Multiple file Add 2 + File mod 2
echo -e "${CYAN} -# 12 Multiple file Add 2 + File mod 2- ${RS}"
touch multi9
touch multi99
echo "xxxxxxxx" >> multi5
echo "xxxxxxxx" >> multi6
git add .
git commit -m "# 12 Multiple file Add 2 + File mod 2"
./git-zip.sh
#mv "${APLICATION}"*.zip 12.zip


# 13 File rm
echo -e "${CYAN} -# 13 File rm- ${RS}"
rm multi1
git add .
git commit -m "# 13 File rm"
./git-zip.sh
#mv "${APLICATION}"*.zip 13.zip


# 14 File add + File rm
echo -e "${CYAN} -# 14 File add + File rm- ${RS}"
touch multi55
rm multi2
git add .
git commit -m "# 14 File add + File rm"
./git-zip.sh
#mv "${APLICATION}"*.zip 14.zip


# 15 File add + File mod + File rm
echo -e "${CYAN} -# 15 File add + File mod + File rm- ${RS}"
touch multi77
rm multi3
echo "xxxxxxxx" >> multi7
git add .
git commit -m "# 15 File add + File mod + File rm"
./git-zip.sh
#mv "${APLICATION}"*.zip 15.zip


# 16 File rename
echo -e "${CYAN} -# 16 File rename- ${RS}"
mv multi4 rename4
git add .
git commit -m "# 16 File rename"
./git-zip.sh
#mv "${APLICATION}"*.zip 16.zip


# 17 File add + File rename + File rm
echo -e "${CYAN} -# 17 File add + File rename + File rm- ${RS}"
touch files88
mv multi5 rename5
rm multi6
git add .
git commit -m "# 17 File add + File rename + File rm"
./git-zip.sh
#mv "${APLICATION}"*.zip 17.zip


# 18 File add + File rename + File rm + File mod
echo -e "${CYAN} -# 18 File add + File rename + File rm + File mod- ${RS}"
touch newfile99
mv multi7 rename7
rm multi8
echo "xxxxxxxx" >> multi9
git add .
git commit -m "# 18 File add + File rename + File rm + File mod"
./git-zip.sh
#mv "${APLICATION}"*.zip 18.zip
