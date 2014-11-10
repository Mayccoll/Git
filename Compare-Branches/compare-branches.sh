#!/bin/bash

# | Command
# git log --left-right --graph --cherry-pick --oneline master..branch


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

BRANCH1="master"
BRANCH2="origin/master"

FILE="compr.tmp"

PWD="$(pwd)"

cd $PWD

git branch -a

echo ""

echo ""

echo -e "$CYAN Type first branch to compare: $RS"
read BRANCH1
echo -e "$CYAN Type second branch to compare: $RS"
read BRANCH2



BRANCH=$( git log --left-right --graph --cherry-pick --oneline ${BRANCH1}..${BRANCH2}  > compr.tmp )
echo ""
if [[ -s $PWD/$FILE ]] ; then
    echo -e "$YELLOW These commits are not in the $GREEN ${BRANCH1} $YELLOW branch: $RS"
    echo -e "$YELLOW you can update running: $RS"
    echo -e "$RED     git checkout ${BRANCH1} $RS"
    echo -e "$RED     git merge  ${BRANCH2} $RS"
    cat compr.tmp
    rm compr.tmp
else
    FLAG1=1
    echo ""
fi;



BRANCH=$( git log --left-right --graph --cherry-pick --oneline ${BRANCH2}..${BRANCH1}  > compr.tmp )
echo ""
if [[ -s $PWD/$FILE ]] ; then
    echo -e "$YELLOW These commits are not in the $GREEN ${BRANCH2} $YELLOW branch: $RS"
    echo -e "$RED     git checkout ${BRANCH2} $RS"
    echo -e "$RED     git merge  ${BRANCH1} $RS"
    cat compr.tmp
    rm compr.tmp
else
    FLAG2=1
    echo ""
fi;


if [ "$FLAG1" == "1" ] && [ "$FLAG2" == "1" ]; then
    rm compr.tmp
    echo "******************************"
    echo -e "*** ${GREEN}Branches are identical ${RS}***"
    echo "******************************"
    echo ""
fi;




# |*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*= | #
# | FIle:                 compare-branches.sh
# | Date of creation:     10/Nov/2014
# | This script compare commits in two branches
# |
# |
# | @author             Miguel D. Quintero
# | @version            1.0
# | @link               http://lanet.co
# |
# | Revision
# |       M (xx/xxx/xxxx)   - No revision yet
# |
# | @**##<==={...{{{(@@**##<====>##**@@)}}}...}===>##**@ | #
# | @@**##<==={...{{{(@@**##<==>##**@@)}}}...}===>##**@@ | #
# | (@@**##<==={...{{{(@@**##<>##**@@)}}}...}===>##**@@) | #
# | {(@@**##<==={...{{{(@@**####**@@)}}}...}===>##**@@)} | #
# | {{(@@**##<==={...{{{(@@**##**@@)}}}...}===>##**@@)}} | #
# | {{{(@@**##<==={...{{{(@@****@@)}}}...}===>##**@@)}}} | #
# | .{{{(@@**##<==={...{{{(@@**@@)}}}...}===>##**@@)}}}. | #
# | ..{{{(@@**##<==={...{{{(@@@@)}}}...}===>##**@@)}}}.. | #
# | ...{{{(@@**##<==={...{{{(@@)}}}...}===>##**@@)}}}... | #
# | {...{{{(@@**##<==={...{{{()}}}...}===>##**@@)}}}...} | #
# | ={...{{{(@@**##<==={...{{()}}...}===>##**@@)}}}...}= | #
# | =={...{{{(@@**##<==={...{()}...}===>##**@@)}}}...}== | #
# | ==={...{{{(@@**##<==={...()...}===>##**@@)}}}...}=== | #
# | <==={...{{{(@@**##<==={......}===>##**@@)}}}...}===> | #
# | #<==={...{{{(@@**##<==={....}===>##**@@)}}}...}===># | #
# | ##<==={...{{{(@@**##<==={..}===>##**@@)}}}...}===>## | #
# | *##<==={...{{{(@@**##<==={}===>##**@@)}}}...}===>##* | #
# | *##<==={...{{{(@@**##<==={}===>##**@@)}}}...}===>##* | #
# | ##<==={...{{{(@@**##<==={..}===>##**@@)}}}...}===>## | #
# | #<==={...{{{(@@**##<==={....}===>##**@@)}}}...}===># | #
# | <==={...{{{(@@**##<==={......}===>##**@@)}}}...}===> | #
# | ==={...{{{(@@**##<==={...()...}===>##**@@)}}}...}=== | #
# | =={...{{{(@@**##<==={...{()}...}===>##**@@)}}}...}== | #
# | ={...{{{(@@**##<==={...{{()}}...}===>##**@@)}}}...}= | #
# | {...{{{(@@**##<==={...{{{()}}}...}===>##**@@)}}}...} | #
# | ...{{{(@@**##<==={...{{{(@@)}}}...}===>##**@@)}}}... | #
# | ..{{{(@@**##<==={...{{{(@@@@)}}}...}===>##**@@)}}}.. | #
# | .{{{(@@**##<==={...{{{(@@**@@)}}}...}===>##**@@)}}}. | #
# | {{{(@@**##<==={...{{{(@@****@@)}}}...}===>##**@@)}}} | #
# | {{(@@**##<==={...{{{(@@**##**@@)}}}...}===>##**@@)}} | #
# | {(@@**##<==={...{{{(@@**####**@@)}}}...}===>##**@@)} | #
# | (@@**##<==={...{{{(@@**##<>##**@@)}}}...}===>##**@@) | #
# | @@**##<==={...{{{(@@**##<==>##**@@)}}}...}===>##**@@ | #
# | @**##<==={...{{{(@@**##<====>##**@@)}}}...}===>##**@ | #
# | 18:2 Y clamó con voz potente, diciendo: Ha caído, ha | #
# | caído la gran Babilonia, y se ha hecho habitación de | #
# | demonios y guarida de todo espíritu inmundo, y       | #
# | albergue de toda ave inmunda y aborrecible.          | #
# |*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=* | #
