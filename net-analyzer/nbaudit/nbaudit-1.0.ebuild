# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nbaudit/nbaudit-1.0.ebuild,v 1.16 2004/08/24 10:37:22 eldad Exp $

# It is officially called nat10 but the name conflicts with other projects
# so I'm following the *BSDs suggestion of calling it nbaudit

MY_P=nat10
S=${WORKDIR}/${MY_P}
DESCRIPTION="NetBIOS file sharing services scanner (nat10)"
SRC_URI="http://www.tux.org/pub/security/secnet/tools/nat10/${MY_P}.tgz"
HOMEPAGE="http://www.tux.org/pub/security/secnet/tools/nat10/"

DEPEND=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""

src_compile() {

	sed -i -e "s/# \(FLAGSM = -DLINUX -DSHADOW_PWD\)/\1 -DNO_ASMSIGNALH/; s;# LIBSM = -lshadow;LIBSM = -lshadow -L/usr/X11R6/lib/modules ;" Makefile

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
