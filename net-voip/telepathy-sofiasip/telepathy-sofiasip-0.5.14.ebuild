# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-sofiasip/telepathy-sofiasip-0.5.14.ebuild,v 1.1 2009/01/13 21:03:57 tester Exp $

DESCRIPTION="A SIP connection manager for Telepathy based around the Sofia-SIP library."
HOMEPAGE="http://sourceforge.net/projects/tp-sofiasip/"
SRC_URI="mirror://sourceforge/tp-sofiasip/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug"

RDEPEND=">=net-libs/sofia-sip-1.12.10
	>=net-libs/telepathy-glib-0.7.17
	>=dev-libs/glib-2.16
	sys-apps/dbus
	dev-libs/dbus-glib"

DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-lang/python"

src_compile() {
	econf $(use_enable debug) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
