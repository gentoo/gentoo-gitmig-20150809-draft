# $Header:
/home/cvsroot/gentoo-x86/app-sci/zetagrid/zetagrid-1.0-r5.ebuild,v 1.1
2003/02/25 22:51:26 tantive Exp $

# ======================================================================
#  zeta_progress.sh      Start script for the ZetaGrid progress utility
# ----------------------------------------------------------------------
#
#  This script sets the environment for the ZetaGrid progress utility.
#
#  Please note:
#
#  - You must adopte the Java call below for your environment.
#
#  - This utility reads the progress file 'zeta_zeros.tmp'
#    which only exists when the ZetaGrid client is running.
#
#  Prerequisite: Java Runtime Environment 1.2.2 or higher,
#                e.g. http://java.sun.com/j2se/1.3/download.html
#
# ======================================================================

java -Djava.library.path=. -cp zeta_client.jar zeta.ShowProgress
