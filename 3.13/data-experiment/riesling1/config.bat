@rem ======================
@rem Settings for riesling1
@rem ======================


set BBS_DEBUG=0

set BBS_NODE_HOSTNAME=riesling1
set BBS_USER=biocbuild
set BBS_WORK_TOPDIR=D:\biocbuild\bbs-3.13-data-experiment
set BBS_R_HOME=D:\biocbuild\bbs-3.13-bioc\R
set BBS_NB_CPU=12
set BBS_CHECK_NB_CPU=16

set BBS_STAGE2_MODE=multiarch
set BBS_STAGE4_MODE=multiarch
set BBS_STAGE5_MODE=multiarch

@rem Central build node is rex3 at BHW.
set BBS_CENTRAL_RHOST=155.52.173.35

@rem When used with StrictHostKeyChecking=no, ssh will automatically add new
@rem host keys to the user known hosts files (so it doesn't get stalled waiting
@rem for an answer when not run interactively).
set BBS_RSH_OPTION=C:\cygwin\bin\ssh.exe -qi D:\biocbuild\.BBS\id_rsa -o StrictHostKeyChecking=no

@rem Source tarballs produced during STAGE3 are BIG and won't be propagated
@rem so we don't need to push them to the central builder.
set DONT_PUSH_SRCPKGS=1



@rem Shared settings (by all Windows nodes)

set wd0=%cd%
cd ..
call config.bat
cd %wd0%
