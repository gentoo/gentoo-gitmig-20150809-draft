# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tapioca-xmpp/tapioca-xmpp-0.3.0.ebuild,v 1.1 2006/05/22 00:08:02 genstef Exp $

DESCRIPTION="Tapioca XMPP protocol"
HOMEPAGE="http://tapioca-voip.sf.net"
SRC_URI="mirror://sourceforge/tapioca-voip/${P}.tar.gz"
SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86"
IUSE=""
RDEPEND="net-im/tapiocad
	net-libs/libjingle
	>=dev-libs/glib-2
	sys-apps/dbus"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
