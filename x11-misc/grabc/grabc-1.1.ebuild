# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/grabc/grabc-1.1.ebuild,v 1.5 2004/11/01 21:00:04 corsair Exp $

S="${WORKDIR}/${PN}${PV}"
DESCRIPTION="A simple but useful program to determine the color string in hex (or RGB components) by clicking on a pixel on the screen"
HOMEPAGE="http://www.muquit.com/muquit/software/grabc/grabc.html"
SRC_URI="http://www.muquit.com/muquit/software/${PN}/${PN}${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ppc ~ppc64"
SLOT="0"
IUSE=""

RDEPEND="virtual/x11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s/-O/${CFLAGS}/" Makefile || \
			die "sed Makefile failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin grabc  || die "dobin failed"
	dodoc README || die "dodoc failed"
}
