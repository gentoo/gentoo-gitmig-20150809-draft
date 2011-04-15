# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/telepathy-idle/telepathy-idle-0.1.9.ebuild,v 1.1 2011/04/15 16:28:11 pacho Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="Full-featured IRC connection manager for Telepathy."
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Components"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND="dev-libs/dbus-glib
	>=dev-libs/glib-2.8.6:2
	>=dev-libs/openssl-0.9.7
	>=net-libs/telepathy-glib-0.13.10
	sys-apps/dbus"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( dev-python/twisted-words )"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS || die
}
