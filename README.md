# Docker Jenkins Backup on S3

Container that backs up Jenkins home directory (Docker version) to S3. The container overwrites the same S3 object every time it is run, it is recommended you turn versioning on to retain access to previous copies.

## Running the backup

To backup your Jenkins home file:

    $ sudo docker run
        -e AWS_ACCESS_KEY_ID=[Your AWS Key ID]
        -e AWS_SECRET_ACCESS_KEY=[Your AWS Access Key]
        -e S3_BUCKET=[Your S3 Bucket]
        -e S3_PATH=[Your S3 Path]
        --volumes-from [the jenkins container name you want to backup]
        seb24/docker-jenkins-s3-backup

*Replace the values with [] using your values*

## Configuration

Name                    |   Default Value   |   Description
---                     |   ---             |   ---
JENKINS_HOME_VOLUME     | /var/jenkins_home | Volume where jenkins store the home files
JENKINS_BACKUP_FILENAME | jenkins_backup    | Backup filename
S3_BUCKET               | `blank`           | Your S3 Bucket
S3_PATH                 | `blank`           | Your S3 path
COMPRESSION_FORMAT      | tar.gz            | Compression format (tar)
AWS_ACCESS_KEY_ID       | `blank`           | Your AWS secret key
AWS_SECRET_ACCESS_KEY   | `blank`           | Your AWS access access
