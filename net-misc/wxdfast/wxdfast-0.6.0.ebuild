# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wxdfast/wxdfast-0.6.0.ebuild,v 1.2 2007/10/21 02:04:59 dirtyepic Exp $

WX_GTK_VER="2.6"

inherit autotools eutils wxwidgets

DESCRIPTION="A multi-treaded cross-platform download manager"
HOMEPAGE="http://dfast.sourceforge.net"
SRC_URI="mirror://sourceforge/dfast/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=x11-libs/wxGTK-2.6*"

pkg_setup() {
	need-wxwidgets unicode
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-wxrc-configure.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog TODO
}
