# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/lcdutils/lcdutils-0.2.ebuild,v 1.6 2005/12/04 18:02:05 vapier Exp $

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
		echo ""
		ewarn "This package is only for Cobalt Microserver systems.  Its use on other types of"
		ewarn "hardware is untested."
		echo ""
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s:CFLAGS=-O2 -Wall:CFLAGS=${CFLAGS}:g" Makefile
}

src_compile() {
	emake distclean || die "distclean failed"
	emake all || die "all failed"
}

src_install() {
	dobin buttond putlcd || die "dobin failed"
	dodoc Changelog
}
