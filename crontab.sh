        ### Cron
        ###########################

# Pull and log
*/3 * * * *   /root/crons/prototiposena.sh  >> ~/crons/logs/prototiposena.log 2>&1
*/3 * * * *   /root/crons/time_stamp.sh  >> ~/crons/logs/prototiposena.log 2>&1


*/3 * * * *   /root/crons/prototiposena_prueba.sh  >> ~/crons/logs/prototiposena_prueba.log 2>&1
*/3 * * * *   /root/crons/time_stamp.sh  >> ~/crons/logs/prototiposena_prueba.log 2>&1




        ### TimeStamp
        ###########################

#!/bin/bash

printf "\n"; \
echo ":::::::::::::::::::::::::"; \
NOW=$(date +"%Y-%m-%d [%H:%M:%S]"); \
echo ${NOW}; \
echo ":::::::::::::::::::::::::"; \
printf "\n";




        ### Shell
        ###########################

#!/bin/bash

###################################
# Repo 
URL="/var/www/html/prototiposena_prueba"

# From
PULL_REPO="origin"

# Branch
BRANCH="Desarrollo"

###################################

cd ${URL} 
git pull ${PULL_REPO} ${BRANCH}
