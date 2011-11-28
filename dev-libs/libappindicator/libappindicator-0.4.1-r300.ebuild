# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libappindicator/libappindicator-0.4.1-r300.ebuild,v 1.1 2011/11/28 15:04:24 ssuominen Exp $

EAPI=4
inherit autotools eutils

PN_vala_version=0.14

DESCRIPTION="A library to allow applications to export a menu into the Unity Menu bar"
HOMEPAGE="http://launchpad.net/libappindicator"
SRC_URI="http://launchpad.net/${PN}/${PV%.*}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection"

# FIXME: Missing dev-lang/mono handling!
RDEPEND="dev-libs/dbus-glib
	>=dev-libs/glib-2.26
	dev-libs/libdbusmenu[gtk,gtk3]
	>=dev-libs/libindicator-0.4:3
	x11-libs/gtk+:3
	introspection? ( >=dev-libs/gobject-introspection-0.10 )"
DEPEND="${RDEPEND}
	dev-lang/vala:${PN_vala_version}[vapigen]
	dev-util/gtk-doc-am
	dev-util/pkgconfig"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-no-mono.patch \
		"${FILESDIR}"/${P}-gtk.patch

	eautoreconf
}

src_configure() {
	export VALAC="$(type -P valac-${PN_vala_version})"

	econf \
		--disable-static \
		--with-html-dir=/usr/share/doc/${PF}/html \
		--with-gtk=3
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog

	find "${ED}"usr -name '*.la' -exec rm -f {} +
}
