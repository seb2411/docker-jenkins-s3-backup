#!/bin/bash

# Variables
JENKINS_BACKUP_TMP=/tmp
JENKINS_HOME_VOLUME=/var/jenkins_home
JENKINS_BACKUP_FILENAME=jenkins_backup
COMPRESSION_FORMAT=tar.gz

# Coloring output
## Orange
orange='\033[0;33m'
## Green
green='\033[0;32m'
## No Color
NC='\033[0m'

# Compress Jenkins data

cd ${JENKINS_HOME_VOLUME}

if [ $? == 0 ]; then

    echo "Compressing files..."

    tar -zcf ${JENKINS_BACKUP_TMP}/${JENKINS_BACKUP_FILENAME}.${COMPRESSION_FORMAT} * .??*

    if [ $? == 0 ]; then
        echo -e "${green}Compression successful!${NC}"

        # Upload backup
        echo "Uploading files to S3..."
        aws s3 cp ${JENKINS_BACKUP_TMP}/${JENKINS_BACKUP_FILENAME}.${COMPRESSION_FORMAT} s3://$S3_BUCKET/$S3_PATH/${JENKINS_BACKUP_FILENAME}.${COMPRESSION_FORMAT}

        if [ $? == 0 ]; then
            echo -e "${green}Backup uploaded successfully!${NC}"
        else
            >&2 echo -e "${orange}Upload to error s3://$S3_BUCKET/$S3_PATH/${JENKINS_BACKUP_FILENAME}.${COMPRESSION_FORMAT} ${NC}"
        fi

    else
        >&2 echo -e "${orange}$COMPRESSION_FORMAT Compression failed for $JENKINS_BACKUP_TMP/$JENKINS_BACKUP_FILENAME.$COMPRESSION_FORMAT in $JENKINS_HOME_VOLUME ${NC}"
    fi

else
    >&2 echo -e "${orange}Couldn't access to the Jenkins Volume - $JENKINS_HOME_VOLUME ${NC}"
fi
