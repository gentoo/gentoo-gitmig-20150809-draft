# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tapioca-xmpp/tapioca-xmpp-0.3.9.ebuild,v 1.8 2009/01/03 22:23:45 halcy0n Exp $

inherit eutils

DESCRIPTION="Tapioca XMPP protocol"
HOMEPAGE="http://tapioca-voip.sf.net"
SRC_URI="mirror://sourceforge/tapioca-voip/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-im/tapiocad
	net-libs/libjingle
	>=dev-libs/glib-2
	>=dev-libs/dbus-glib-0.71"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
