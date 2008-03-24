# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/tsemgr/tsemgr-0.08.ebuild,v 1.4 2008/03/24 12:19:43 maekke Exp $

inherit eutils autotools

DESCRIPTION="Utility for Ericsson Mobile Phones"
HOMEPAGE="http://sourceforge.net/projects/tsemgr/"
SRC_URI="mirror://sourceforge/tsemgr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1*
	dev-libs/openobex
	dev-libs/libezV24"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	eautoreconf
}

src_install(){
	emake DESTDIR="${D}" install || die "Installation failed."
	dodoc README NEWS TODO AUTHORS
}
