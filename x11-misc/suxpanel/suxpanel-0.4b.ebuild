# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/suxpanel/suxpanel-0.4b.ebuild,v 1.1 2007/03/10 12:27:56 drac Exp $

inherit eutils

DESCRIPTION="SuxPanel is a complete rewrite of MacOS Style Panel, a light-weight X11 desktop panel"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"
HOMEPAGE="http://suxpanel.berlios.de"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	x11-libs/libwnck"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-Makefile.in.patch"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed."
	dobin suxpanel-install.sh
	dodoc README
}
