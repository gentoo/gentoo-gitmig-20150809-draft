# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-sofiasip/telepathy-sofiasip-0.6.2.ebuild,v 1.8 2010/08/07 16:53:55 armin76 Exp $

inherit autotools

DESCRIPTION="A SIP connection manager for Telepathy based around the Sofia-SIP library."
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="test"

RDEPEND=">=net-libs/sofia-sip-1.12.10
	>=net-libs/telepathy-glib-0.8.0
	>=dev-libs/glib-2.16
	sys-apps/dbus
	dev-libs/dbus-glib"

DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-lang/python
	test? ( dev-python/twisted )"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
