#!/bin/bash

# |
# | Colors
# | ____________________________________________________________________________

# Reset color
RS="\e[0m"            # "${RS}"
# Basic Colors
BLACK="\e[0;30m"      # "${BLACK}"
RED="\e[0;31m"        # "${RED}"
GREEN="\e[0;32m"      # "${GREEN}"
YELLOW="\e[0;33m"     # "${YELLOW}"
BLUE="\e[0;34m"       # "${BLUE}"
PURPLE="\e[0;35m"     # "${PURPLE}"
CYAN="\e[0;36m"       # "${CYAN}"
WHITE="\e[0;37m"      # "${WHITE}"

# Script path
SCRIPT_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
APLICATION=${PWD##*/}
TO_COMMIT="HEAD" #  ( Newest Commit )




echo -e "
${BLACK}:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:${RS}
${BLACK}:=:=:=:=:   ${RS}Git Zip          ${BLACK}=:=:=:=:=:=:=:=:${RS}
${BLACK}:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:${RS}
"

# |
# | Echo Commits
# | ____________________________________________________________________________

cd "${SCRIPT_PATH}"
GIT_LOGS=$(git log --pretty=format:'%Cred%h%Creset - "%s" %Creset' --abbrev-commit -20)
echo "${GIT_LOGS[@]}"

# |
# | Input commits
# | ____________________________________________________________________________

echo ""
echo ""
echo ""
echo -e "Select commit from (Oldest Commit) :"
read FROM_COMMIT_AMP
if [[ $FROM_COMMIT_AMP == "" ]]; then
  FROM_COMMIT_AMP="HEAD^"
else
  FROM_COMMIT=$FROM_COMMIT_AMP
  FROM_COMMIT_AMP=$FROM_COMMIT_AMP"^"
fi


# |
# | Variables
# | ____________________________________________________________________________

# Get commit hash
cd "${SCRIPT_PATH}"
HASHMARK_TO=`git rev-parse --short=7 $TO_COMMIT`
cd "${SCRIPT_PATH}"
HASHMARK_FROM=`git rev-parse --short=7 $FROM_COMMIT_AMP`

GIT_DIFF=$(git diff $FROM_COMMIT_AMP HEAD --name-only --diff-filter=ACMRTUXB)
GIT_DIFF_TEXT=$(echo $GIT_DIFF)


# Create zip file between commits using filter.
GIT_ZIP="git archive  --format=zip HEAD ${GIT_DIFF_TEXT}"

GIT_ZIP_TEXT=$(echo $GIT_ZIP)


if [[  $GIT_ZIP_TEXT != "git archive --format=zip HEAD" ]]; then

cd "${SCRIPT_PATH}"
FILE_NAME="${APLICATION}".$(date +\%Y\%m\%d).$HASHMARK_TO.$FROM_COMMIT.zip
cd "${SCRIPT_PATH}"
$GIT_ZIP > "${SCRIPT_PATH}/${FILE_NAME}"
# List files in zip
FILE_LIST=$(unzip -l "${SCRIPT_PATH}/${FILE_NAME}" | awk '/-----/ {p = ++p % 2; next} p {print $NF}')
GIT_LOGS_MESSAGE=$(git log --pretty=format:'"%s"' --abbrev-commit -1)


echo -e "
${BLACK}:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:${RS}
${BLACK}:=:=:=:=:   ${RS}Zip file created ${BLACK}=:=:=:=:=:=:=:=:${RS}
${BLACK}:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:${RS}

File name :
${YELLOW}${FILE_NAME}${RS}

Path :
${YELLOW}${SCRIPT_PATH}/${RS}

Files Between Commits
${YELLOW}${HASHMARK_TO}${RS} - ${YELLOW}${FROM_COMMIT}${RS} ${BLACK} <=== ${RS}

Commit Message:
${YELLOW}${GIT_LOGS_MESSAGE}${RS}

Files in zip:
${YELLOW}${FILE_LIST}${RS}

${BLACK}:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:${RS}
${BLACK}:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:${RS}
${BLACK}:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:${RS}
"

else

echo -e "
${BLACK}:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:${RS}
${BLACK}:=:=:=:=:   ${RED}Zip NOT created ${BLACK}=:=:=:=:=:=:=:=:${RS}
${BLACK}:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:${RS}

${YELLOW} Commit is empty ${RS}

${BLACK}:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:${RS}
${BLACK}:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:${RS}
${BLACK}:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:${RS}
"
fi







# |*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=**=*=*=*=*=*=*
# | FIle:                 git-zip.sh
# | Date of creation:     10/Jun/2014
# | This script creates a zip file with all new or modified files between two
# | commits, including the folders structure.
# |
# |
# | @author             Miguel D. Quintero
# | @version            2.0
# | @link               http://www.lenet.com.co
# |
# | Revision
# |       M (13/Jun/2014)   - If statement
# |       M (12/Jul/2014)   - add filter for deleted files
# |       M (05/Sep/2014)   - Fix bug for new files
# |       M (09/Sep/2014)   - All
# |
# | @**##<==={...{{{(@@**##<====>##**@@)}}}...}===>##**@
# | @@**##<==={...{{{(@@**##<==>##**@@)}}}...}===>##**@@
# | (@@**##<==={...{{{(@@**##<>##**@@)}}}...}===>##**@@)
# | {(@@**##<==={...{{{(@@**####**@@)}}}...}===>##**@@)}
# | {{(@@**##<==={...{{{(@@**##**@@)}}}...}===>##**@@)}}
# | {{{(@@**##<==={...{{{(@@****@@)}}}...}===>##**@@)}}}
# | .{{{(@@**##<==={...{{{(@@**@@)}}}...}===>##**@@)}}}.
# | ..{{{(@@**##<==={...{{{(@@@@)}}}...}===>##**@@)}}}..
# | ...{{{(@@**##<==={...{{{(@@)}}}...}===>##**@@)}}}...
# | {...{{{(@@**##<==={...{{{()}}}...}===>##**@@)}}}...}
# | ={...{{{(@@**##<==={...{{()}}...}===>##**@@)}}}...}=
# | =={...{{{(@@**##<==={...{()}...}===>##**@@)}}}...}==
# | ==={...{{{(@@**##<==={...()...}===>##**@@)}}}...}===
# | <==={...{{{(@@**##<==={......}===>##**@@)}}}...}===>
# | #<==={...{{{(@@**##<==={....}===>##**@@)}}}...}===>#
# | ##<==={...{{{(@@**##<==={..}===>##**@@)}}}...}===>##
# | *##<==={...{{{(@@**##<==={}===>##**@@)}}}...}===>##*
# | *##<==={...{{{(@@**##<==={}===>##**@@)}}}...}===>##*
# | ##<==={...{{{(@@**##<==={..}===>##**@@)}}}...}===>##
# | #<==={...{{{(@@**##<==={....}===>##**@@)}}}...}===>#
# | <==={...{{{(@@**##<==={......}===>##**@@)}}}...}===>
# | ==={...{{{(@@**##<==={...()...}===>##**@@)}}}...}===
# | =={...{{{(@@**##<==={...{()}...}===>##**@@)}}}...}==
# | ={...{{{(@@**##<==={...{{()}}...}===>##**@@)}}}...}=
# | {...{{{(@@**##<==={...{{{()}}}...}===>##**@@)}}}...}
# | ...{{{(@@**##<==={...{{{(@@)}}}...}===>##**@@)}}}...
# | ..{{{(@@**##<==={...{{{(@@@@)}}}...}===>##**@@)}}}..
# | .{{{(@@**##<==={...{{{(@@**@@)}}}...}===>##**@@)}}}.
# | {{{(@@**##<==={...{{{(@@****@@)}}}...}===>##**@@)}}}
# | {{(@@**##<==={...{{{(@@**##**@@)}}}...}===>##**@@)}}
# | {(@@**##<==={...{{{(@@**####**@@)}}}...}===>##**@@)}
# | (@@**##<==={...{{{(@@**##<>##**@@)}}}...}===>##**@@)
# | @@**##<==={...{{{(@@**##<==>##**@@)}}}...}===>##**@@
# | @**##<==={...{{{(@@**##<====>##**@@)}}}...}===>##**@
# | Apo 1:8 Yo soy el Alfa y la Omega, principio y fin,
# | dice el Señor, el que es y que era y que ha de venir,
# | el Todopoderoso.
# |*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=**=*=*=*=*=*=*
