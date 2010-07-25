# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/telepathy-idle/telepathy-idle-0.1.5.ebuild,v 1.6 2010/07/25 15:25:23 klausman Exp $

EAPI=2
inherit eutils

DESCRIPTION="Full-featured IRC connection manager for Telepathy."
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Components"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="test"

RDEPEND="dev-libs/dbus-glib
	>=dev-libs/glib-2.8.6:2
	>=dev-libs/openssl-0.9.7
	>=net-libs/telepathy-glib-0.7.15
	sys-apps/dbus"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( dev-python/twisted-words )"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS || die
}
