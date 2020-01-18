! /usr/bin/ksh

#
# -----------------------------------------------------------------------------
#
#                             Nokia - Proprietary
#                    Use Pursuant to Company Instructions
#
# -----------------------------------------------------------------------------
#

MAILX=/usr/bin/mailx

#
# Gather the data we need
#
RECIPIENT=${1}
REPLYTO=${2}
DATESTAMP=${3}
CSVFILE=${4}
LOGFILE=${5}
TOTAL_RECORDS_INSERTED=${6}
TOTAL_SLA=${7}

if [ -z "${RECIPIENT}" ]; then
    print -u2 "\nERROR:  Recipient address not provided.  Exiting.\n\n";
    exit 90
fi

if [ -z "${REPLYTO}" ]; then
    print -u2 "\nERROR:  Reply-To address not provided.  Exiting.\n\n";
    exit 91
fi
if [ -z "${DATESTAMP}" ]; then
    print -u2 "\nERROR:  Datestamp not provided.  Exiting.\n\n";
    exit 92
fi

if [ -z "${CSVFILE}" ]; then
    print -u2 "\nERROR:  CSV file name not provided.  Exiting.\n\n";
    exit 93
fi

if [ -z "${LOGFILE}" ]; then
    print -u2 "\nERROR:  Log file name not provided.  Exiting.\n\n";
    exit 94
fi

if [ -z "${TOTAL_RECORDS_INSERTED}" ]; then
    print -u2 "\nERROR:  Total number of records inserted was not provided.  Exiting.\n\n";
    exit 95
fi
if [ -z "${TotalConsolidated}" ]; then
    print -u2 "\nERROR:  Total number of incoming records was not provided.  Exiting.\n\n";
    exit 96
fi

SUBJECT="[CRON] CSFS JIRA SLA Data Retrieval Completed (${DATESTAMP})"

MESSAGE="
The CSFS JIRA sla data collection script was run (${DATESTAMP}).

----


[Summary]

- Total SLA Count :  ${TOTAL_SLA}
- MariaDB Updates:  ${TOTAL_RECORDS_INSERTED}

The output can be viewed, here:

[CSV]

http://csfci.ih.lucent.com/powerbi/csv/LATEST_SLA_CSV.csv


[Logs]

http://csfci.ih.lucent.com/powerbi/logs/LATEST_SLA_LOG.txt


Regards,

CSF Integration Team

"

${MAILX}            \
    -s "${SUBJECT}" \
    -r ${REPLYTO}   \
    ${RECIPIENT} <<- EOT
${MESSAGE}
EOT

