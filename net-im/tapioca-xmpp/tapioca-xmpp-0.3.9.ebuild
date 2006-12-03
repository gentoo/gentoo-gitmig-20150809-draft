# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tapioca-xmpp/tapioca-xmpp-0.3.9.ebuild,v 1.5 2006/12/03 10:39:03 peper Exp $

DESCRIPTION="Tapioca XMPP protocol"
HOMEPAGE="http://tapioca-voip.sf.net"
SRC_URI="mirror://sourceforge/tapioca-voip/${P}.tar.gz"
SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="net-im/tapiocad
	net-libs/libjingle
	>=dev-libs/glib-2
	|| ( >=dev-libs/dbus-glib-0.71
		( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.34 ) )"

RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
