# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nbaudit/nbaudit-1.0.ebuild,v 1.5 2002/02/14 05:09:36 blocke Exp $


# Its officially called nat10 but the name conflicts with other projects
# so I'm following the *BSDs suggestion of calling it nbaudit

A=nat10.tgz
P=nat10
S=${WORKDIR}/${P}
DESCRIPTION="NetBIOS file sharing services scanner (nat10)"
SRC_URI="http://www.tux.org/pub/security/secnet/tools/nat10/${A}"
HOMEPAGE="http://www.tux.org/pub/security/secnet/tools/nat10"

DEPEND=""

src_compile() {

   mv Makefile Makefile.old
   sed -e "s/# FLAGSM = -DLINUX -DSHADOW_PWD/FLAGSM = -DLINUX -DSHADOW_PWD -DNO_ASMSIGNALH/" -e "s/# LIBSM = -lshadow/LIBSM = -lshadow/" Makefile.old > Makefile

   # NOTE: DO NOT SET CFLAGS OR THE PROGRAM WILL SEGFAULT
   try make all

}

src_install () {

    mv nat nbaudit
    dobin nbaudit

    mv nat.1 nbaudit.1
    doman nbaudit.1

    dodoc README COPYING
}
