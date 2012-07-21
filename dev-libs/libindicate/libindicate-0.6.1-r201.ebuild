# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicate/libindicate-0.6.1-r201.ebuild,v 1.5 2012/07/21 18:40:45 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"

inherit autotools eutils python

PV_vala_version=0.14

DESCRIPTION="A library to raise flags on DBus for other components of the desktop to pick up and visualize"
HOMEPAGE="http://launchpad.net/libindicate"
SRC_URI="http://launchpad.net/${PN}/${PV%.*}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection"

# note: pull in SLOT="3" to install headers and libs (see rm -rf in src_install)
RDEPEND=">=dev-libs/dbus-glib-0.76
	>=dev-libs/glib-2.18:2
	>=dev-libs/libdbusmenu-0.3.97:0[introspection?]
	dev-libs/libxml2:2
	dev-python/pygtk:2
	>=x11-libs/gtk+-2.12:2
	${CATEGORY}/${PN}:3
	introspection? ( dev-libs/gobject-introspection )
	!<${CATEGORY}/${PN}-0.6.1-r201"
DEPEND="${RDEPEND}
	gnome-base/gnome-common
	app-text/gnome-doc-utils
	dev-util/gtk-doc-am
	dev-lang/vala:${PV_vala_version}[vapigen]
	virtual/pkgconfig"

RESTRICT="test" # for -no-mono.patch

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-mono.patch

	sed -i -e 's:-Werror::' {examples,libindicate,libindicate-gtk}/Makefile.{am,in} || die

	# for slotted dev-lang/vala
	sed -i -e "s:vapigen:vapigen-${PV_vala_version}:" configure.ac || die

	sed -i -e '/^#include.*glib.*gmessages/d' ${PN}/indicator.c || die #427480

	eautoreconf

	>py-compile
}

src_configure() {
	econf \
		--disable-static \
		$(use_enable introspection) \
		--with-gtk=2
}

src_install() {
	emake DESTDIR="${D}" install
	find "${ED}"usr -name '*.la' -exec rm -f {} +

	# note: purposely not installing documentation and colliding files to
	# support SLOT="3"
	rm -rf \
		"${ED}"usr/include/${PN}-0.6/${PN}* \
		"${ED}"usr/share/doc \
		"${ED}"usr/share/gir-1.0/Indicate-0.6.gir \
		"${ED}"usr/share/gtk-doc \
		"${ED}"usr/share/vala/vapi/Indicate-0.6.vapi \
		"${ED}"usr/lib*/girepository-1.0/Indicate-0.6.typelib \
		"${ED}"usr/lib*/${PN}.so* \
		"${ED}"usr/lib*/pkgconfig/indicate-0.6.pc
}

pkg_postinst() {
	python_mod_optimize indicate
}

pkg_postrm() {
	python_mod_cleanup indicate
}
