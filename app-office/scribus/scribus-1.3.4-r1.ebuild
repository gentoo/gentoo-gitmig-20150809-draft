# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/scribus/scribus-1.3.4-r1.ebuild,v 1.4 2009/12/26 19:27:03 pva Exp $

EAPI=1

inherit qt3 eutils

DESCRIPTION="Desktop Publishing (DTP) and Layout program for Linux."
HOMEPAGE="http://www.scribus.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="x11-libs/qt:3
	>=media-libs/freetype-2.1
	>=media-libs/lcms-1.09
	media-libs/tiff
	>=media-libs/libart_lgpl-2.3.8
	>=sys-devel/gcc-3.0.0
	>=dev-libs/libxml2-2.6.0
	>=x11-libs/cairo-1.4.0"

RDEPEND="${DEPEND}
	app-text/ghostscript-gpl"

pkg_setup() {
	if ! built_with_use 'x11-libs/cairo' 'X' 'svg'; then
		eerror "You must build cairo with X and svg support"
		die "x11-libs/cairo built without X and/or svg"
	fi
}

src_compile() {
	econf --enable-cairo || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog README TODO

	domenu scribus.desktop
	doicon scribus/icons/scribusicon.png
}
