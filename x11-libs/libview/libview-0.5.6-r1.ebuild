# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libview/libview-0.5.6-r1.ebuild,v 1.1 2007/04/04 19:17:39 compnerd Exp $

inherit gnome2

DESCRIPTION="VMware's Incredibly Exciting Widgets"
HOMEPAGE="http://view.sourceforge.net"
SRC_URI="mirror://sourceforge/view/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.4.0
		 >=dev-cpp/gtkmm-2.4"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_unpack() {
	gnome2_src_unpack

	cd ${S}
	epatch ${FILESDIR}/${PN}-0.5.6-pcfix.patch
}
