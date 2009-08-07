# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/telepathy-idle/telepathy-idle-0.1.2.ebuild,v 1.6 2009/08/07 12:29:42 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="Full-featured IRC connection manager for Telepathy."
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Components"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~arm ~alpha ~amd64 ~ia64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-libs/dbus-glib
	>=dev-libs/glib-2.8.6:2
	dev-libs/openssl
	net-libs/telepathy-glib
	sys-apps/dbus"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS || die
}
