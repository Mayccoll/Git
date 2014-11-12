#!/bin/bash

# |
# | FAST USE:
# | $ wget -O xm  http://git.io/iP90OQ && chmod +x xm && ./xm && rm xm
# | ____________________________________________________________________________

# |
# | Color  Variables
# | ____________________________________________________________________________

# Reset color
RS="\e[0m"            # "${RS}"

# Basic Colors
BLACK="\e[0;30m"      # "${BLACK}"
ON_BLACK="\e[0;40m"   # "${BLACK}"
RED="\e[0;31m"        # "${RED}"
GREEN="\e[0;32m"      # "${GREEN}"
YELLOW="\e[0;33m"     # "${YELLOW}"
BLUE="\e[0;34m"       # "${BLUE}"
PURPLE="\e[0;35m"     # "${PURPLE}"
CYAN="\e[0;36m"       # "${CYAN}"
WHITE="\e[0;37m"      # "${WHITE}"

# |
# | Variables
# | ____________________________________________________________________________
# || Get the Script path
SCRIPT_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
# || Get the folder name
APLICATION=${PWD##*/}
# || Newest Commit
TO_COMMIT="HEAD"

# |
# | Echo Header
# | ____________________________________________________________________________
echo -e "
${ON_BLACK}:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:${RS}
${ON_BLACK}:=:=:=:=:=:      ${YELLOW}Git Zip${ON_BLACK}       =:=:=:=:=:=:=:=:=:${RS}
${ON_BLACK}:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:=:${RS}
This script will  create a zip  file with all
changed files between the last commit and the
one you select keeping the folder  structure.
"
read -p ">> Press [Enter] to list the las 20 commits..."


# |
# | Echo Last Commits
# | ____________________________________________________________________________
cd "${SCRIPT_PATH}"
GIT_LOGS=$(git log --pretty=format:'%C(Yellow)%h%Creset - "%s" %Creset' --abbrev-commit -20)
echo "${GIT_LOGS[@]}"



# |
# | Input commits
# | ____________________________________________________________________________
echo ""
echo ""
echo ""
echo -e ">> Insert the ${YELLOW}commit${RS} from which you want to create the zip file (Oldest Commit):"
read FROM_COMMIT_AMP
if [[ $FROM_COMMIT_AMP == "" ]]; then
  FROM_COMMIT_AMP="HEAD^"
else
  FROM_COMMIT_AMP=$FROM_COMMIT_AMP"^"
fi



# |
# | Store commnads in Variables
# | ____________________________________________________________________________

# || Get commit hash in short format
cd "${SCRIPT_PATH}"
HASHMARK_TO=`git rev-parse --short=7 $TO_COMMIT`
cd "${SCRIPT_PATH}"
HASHMARK_FROM=`git rev-parse --short=7 $FROM_COMMIT_AMP`

# || List all changed files
# GIT_DIFF=$(git diff $FROM_COMMIT_AMP HEAD --name-only --diff-filter=ACMRTUXB)
GIT_DIFF=$( git show  --stat --oneline --name-status --pretty="format:"  "${HASHMARK_FROM}..${HASHMARK_TO}" |  tr -d " \t\r" | sed '/^D/ d' | sed 's/^.//' | sed '/^\s*$/d' )
GIT_DIFF_TEXT=$(echo $GIT_DIFF)

# || Create zip file between commits using filter.
GIT_ZIP="git archive  --format=zip HEAD ${GIT_DIFF_TEXT}"
GIT_ZIP_TEXT=$(echo $GIT_ZIP)



if [[  $GIT_ZIP_TEXT != "git archive --format=zip HEAD" ]]; then

  # || Store the name for the zip file
  cd "${SCRIPT_PATH}"
  FILE_NAME="${APLICATION}".$(date +\%Y\%m\%d).$HASHMARK_FROM.$HASHMARK_TO.zip

  # || Make the zip
  cd "${SCRIPT_PATH}"
  $GIT_ZIP > "${SCRIPT_PATH}/${FILE_NAME}"

  # || List files in zip
  FILE_LIST=$(unzip -l "${SCRIPT_PATH}/${FILE_NAME}" | awk '/-----/ {p = ++p % 2; next} p {print $NF}')
  GIT_LOGS_MESSAGE=$(git log --pretty=format:'"%s"' --abbrev-commit -1)

  # || Echo output
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
# | @version            3.1
# | @link              http://www.lenet.com.co
# |
# | Revision
# |       M (13/Jun/2014)   - If statement
# |       M (12/Jul/2014)   - add filter for deleted files
# |       M (05/Sep/2014)   - Fix bug for new files
# |       M (09/Sep/2014)   - All
# |       M (16/Oct/2014)   - New version - avoid empty diff
# |       M (12/Nov/2014)   - Add more messages
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
