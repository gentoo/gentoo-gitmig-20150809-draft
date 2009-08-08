# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-idle/telepathy-idle-0.1.4.ebuild,v 1.3 2009/08/08 03:07:22 tester Exp $

DESCRIPTION="A IRC connection manager for Telepathy"
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"


LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=net-libs/telepathy-glib-0.7.15
	=dev-libs/glib-2*
	sys-apps/dbus
	>=dev-libs/openssl-0.9.7
	dev-libs/dbus-glib"

DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-lang/python
	test? ( dev-python/twisted-words )"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
