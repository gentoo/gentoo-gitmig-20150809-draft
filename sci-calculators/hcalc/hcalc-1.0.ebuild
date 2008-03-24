# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/hcalc/hcalc-1.0.ebuild,v 1.7 2008/03/24 16:44:47 coldwind Exp $

DESCRIPTION="DJ's Hex Calculator"
HOMEPAGE="http://www.delorie.com/store/hcalc/"
SRC_URI="http://www.delorie.com/store/hcalc/${PN}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="x11-libs/libXpm"

S=${WORKDIR}

src_compile() {
	sed 's|'-lX11'|'"-lX11 -L/usr/X11R6/lib"'|' Makefile > Makefile_fixed
	make -f Makefile_fixed || die
}

src_install() {
	dobin hcalc
}

pkg_postinst() {
	einfo "Enter hcalc to run and use kill or ctrl-c to exit."
}
