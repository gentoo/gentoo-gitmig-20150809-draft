# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicate/libindicate-0.6.1-r300.ebuild,v 1.3 2011/11/28 22:39:35 zmedico Exp $

EAPI=4
inherit autotools eutils

PV_vala_version=0.14

DESCRIPTION="A library to raise flags on DBus for other components of the desktop to pick up and visualize"
HOMEPAGE="http://launchpad.net/libindicate"
SRC_URI="http://launchpad.net/${PN}/${PV%.*}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection"

RDEPEND=">=dev-libs/dbus-glib-0.76
	>=dev-libs/glib-2.18:2
	>=dev-libs/libdbusmenu-0.3.97:3[introspection?]
	dev-libs/libxml2:2
	x11-libs/gtk+:3
	introspection? ( dev-libs/gobject-introspection )
	!<${CATEGORY}/${PN}-0.6.1-r201"
DEPEND="${RDEPEND}
	gnome-base/gnome-common
	app-text/gnome-doc-utils
	dev-util/gtk-doc-am
	dev-util/pkgconfig
	dev-lang/vala:${PV_vala_version}[vapigen]"

RESTRICT="test" # for -no-mono.patch

DOCS=( AUTHORS ChangeLog )

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-mono.patch

	sed -i -e 's:-Werror::' {examples,libindicate,libindicate-gtk}/Makefile.{am,in} || die

	# for slotted dev-lang/vala
	sed -i -e "s:vapigen:vapigen-${PV_vala_version}:" configure.ac || die

	eautoreconf
}

src_configure() {
	# note: --disable-python to avoid automagic gtk+-2.0 usage
	econf \
		--docdir=/usr/share/doc/${PF} \
		--disable-static \
		$(use_enable introspection) \
		--disable-python \
		--with-gtk=3 \
		--with-html-dir=/usr/share/doc/${PF}
}

src_install() {
	default
	find "${ED}"usr -name '*.la' -exec rm -f {} +
}
