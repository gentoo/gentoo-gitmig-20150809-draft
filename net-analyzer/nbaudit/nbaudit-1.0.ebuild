# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nbaudit/nbaudit-1.0.ebuild,v 1.9 2002/08/14 12:12:12 murphy Exp $


# Its officially called nat10 but the name conflicts with other projects
# so I'm following the *BSDs suggestion of calling it nbaudit

MY_P=nat10
S=${WORKDIR}/${MY_P}
DESCRIPTION="NetBIOS file sharing services scanner (nat10)"
SRC_URI="http://www.tux.org/pub/security/secnet/tools/nat10/${MY_P}.tgz"
HOMEPAGE="http://www.tux.org/pub/security/secnet/tools/nat10"

DEPEND=""

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 sparc sparc64"

src_compile() {

	mv Makefile Makefile.old
	sed -e "s/# \(FLAGSM = -DLINUX -DSHADOW_PWD\)/\1 -DNO_ASMSIGNALH/" \
		-e "s/# LIBSM = -lshadow/LIBSM = -lshadow/" \
		Makefile.old > Makefile

	# NOTE: DO NOT SET CFLAGS OR THE PROGRAM WILL SEGFAULT
	make all || die

}

src_install () {

	mv nat nbaudit
	dobin nbaudit

	mv nat.1 nbaudit.1
	doman nbaudit.1

	dodoc README COPYING
}
