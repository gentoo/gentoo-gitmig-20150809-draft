# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lcdutils/lcdutils-0.2.ebuild,v 1.1 2004/02/01 07:29:10 kumba Exp $

DESCRIPTION="Cobalt RaQ/Qube LCD Writing and Button reading utilities"
HOMEPAGE=""
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* mips"
IUSE=""

DEPEND=""

S=${WORKDIR}/${P}

pkg_setup() {
	# See if we're on a cobalt system (must use the cobalt-mips profile)
	if [ "${PROFILE_ARCH}" != "cobalt" ]; then
		echo -e ""
		eerror "This package is only for Cobalt Microserver systems.  It is not"
		eerror "useful for any other type of system currently."
		echo -e ""
		die "Wrong system!"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile Makefile.orig
	sed -e "s:CFLAGS=-O2 -Wall:CFLAGS=${CFLAGS}:g" Makefile.orig > Makefile
}

src_compile() {
	cd ${S}
	emake distclean
	emake all
}

src_install() {
	cd ${S}
	dobin buttond putlcd
	dodoc Changelog COPYING
}
