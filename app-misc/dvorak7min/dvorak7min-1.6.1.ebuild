# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/dvorak7min/dvorak7min-1.6.1.ebuild,v 1.1 2003/08/27 20:57:59 pylon Exp $

DESCRIPTION="dvorak7min is a simple ncurses-based typing tutor for those trying to become fluent with the Dvorak keyboard layout."
SRC_URI="http://www.linalco.com/ragnar/${P}.tar.gz"
HOMEPAGE="http://www.linalco.com/comunidad.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=""
S="${WORKDIR}/${P}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
}

src_compile() {
	make clean
	emake || die "Make failed"
}

src_install() {
	## EXEs
	dobin dvorak7min
	## DOCS
	dodoc \
		ChangeLog \
		README
}
