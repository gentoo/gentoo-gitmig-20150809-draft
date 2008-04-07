# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/suxpanel/suxpanel-0.4b-r1.ebuild,v 1.2 2008/04/07 20:11:12 drac Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="SuxPanel is a complete rewrite of MacOS Style Panel, a light-weight X11 desktop panel"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"
HOMEPAGE="http://suxpanel.berlios.de"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	x11-libs/libwnck"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-Makefile.in.patch
	epatch "${FILESDIR}"/${P}-stdlib.patch
}

src_compile() {
	use amd64 && append-flags -O0
	tc-export CC
	econf
	emake || die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	dobin suxpanel-install.sh
	dodoc README
}
