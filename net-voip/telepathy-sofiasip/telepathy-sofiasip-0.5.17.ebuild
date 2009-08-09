# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-sofiasip/telepathy-sofiasip-0.5.17.ebuild,v 1.5 2009/08/09 14:19:15 mr_bones_ Exp $

inherit autotools

DESCRIPTION="A SIP connection manager for Telepathy based around the Sofia-SIP library."
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug test"

RDEPEND=">=net-libs/sofia-sip-1.12.10
	>=net-libs/telepathy-glib-0.7.27
	>=dev-libs/glib-2.16
	sys-apps/dbus
	dev-libs/dbus-glib"

DEPEND="${RDEPEND}
	dev-libs/libxslt
	dev-lang/python
	test? ( dev-python/twisted )"

src_unpack() {
	unpack ${A}

	cd "${S}"
	sed -i -e "s/python2.5/python2.6 python2.5/" configure.ac
	eautoreconf
}

src_compile() {
	econf $(use_enable debug) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
