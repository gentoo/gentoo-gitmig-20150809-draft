# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lcdutils/lcdutils-0.2.ebuild,v 1.5 2004/07/15 01:48:11 agriffis Exp $

DESCRIPTION="Cobalt RaQ/Qube LCD Writing and Button reading utilities"
HOMEPAGE=""
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* mips ~x86"
IUSE=""

DEPEND=""

pkg_setup() {
	# This package is aimed primarily at Cobalt Microserver systems.  Mips originally, but it
	# is reported to work on x86-based systems as well.
	if [ "${PROFILE_ARCH}" != "cobalt" ]; then
		echo -e ""
		ewarn "This package is only for Cobalt Microserver systems.  Its use on other types of"
		ewarn "hardware is untested."
		echo -e ""
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
