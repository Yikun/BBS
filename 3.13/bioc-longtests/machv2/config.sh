#!/bin/bash
# ===================
# Settings for machv2
# ===================



#set -x  # print commands and their arguments as they are executed

export BBS_DEBUG="0"

export BBS_NODE_HOSTNAME="machv2"
export BBS_USER="biocbuild"
export BBS_WORK_TOPDIR="/Users/biocbuild/bbs-3.13-bioc-longtests"
export BBS_R_HOME="/Library/Frameworks/R.framework/Versions/Current/Resources"
export BBS_NB_CPU=4  # 24 cores are available

# Central build node is rex3 at BHW.
export BBS_CENTRAL_RHOST="155.52.173.35"

# When used with StrictHostKeyChecking=no, ssh will automatically add new
# host keys to the user known hosts files (so it doesn't get stalled waiting
# for an answer when not run interactively).
export BBS_RSH_CMD="/usr/bin/ssh -qi /Users/biocbuild/.BBS/id_rsa -o StrictHostKeyChecking=no -J biocbuild@ada.dfci.harvard.edu"



# Shared settings (by all Unix nodes).

wd0=$(pwd)
cd ..
. ./config.sh
cd "$wd0"
