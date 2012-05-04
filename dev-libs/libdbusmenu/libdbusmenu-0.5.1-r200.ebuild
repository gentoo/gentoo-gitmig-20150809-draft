# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdbusmenu/libdbusmenu-0.5.1-r200.ebuild,v 1.4 2012/05/04 13:07:58 johu Exp $

EAPI=4

PN_vala_version=0.14

inherit virtualx

DESCRIPTION="Library to pass menu structure across DBus"
HOMEPAGE="https://launchpad.net/dbusmenu"
SRC_URI="http://launchpad.net/dbusmenu/${PV%.*}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk +introspection test"

# note: pulling in SLOT="3" for headers and more, see rm -rf in src_install()
RDEPEND=">=dev-libs/glib-2.26
	dev-libs/dbus-glib
	dev-libs/libxml2
	gtk? ( >=x11-libs/gtk+-2.16:2 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )
	${CATEGORY}/${PN}:3
	!<${CATEGORY}/${PN}-0.5.1-r200"
DEPEND="${RDEPEND}
	test? (
		dev-libs/json-glib[introspection?]
		dev-util/dbus-test-runner
	)
	dev-lang/vala:${PN_vala_version}[vapigen]
	app-text/gnome-doc-utils
	dev-util/intltool
	virtual/pkgconfig"

src_prepare() {
	# Drop DEPRECATED flags, bug #391103
	sed -i \
		-e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' \
		{libdbusmenu-{glib,gtk},tests}/Makefile.{am,in} configure{,.ac} || die
}

src_configure() {
	export VALA_API_GEN="$(type -P vapigen-${PN_vala_version})"

	econf \
		--disable-static \
		$(use_enable gtk) \
		$(use_enable gtk dumper) \
		$(use_enable introspection) \
		$(use_enable test tests) \
		--with-gtk=2
}

src_test() {
	Xemake check
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	find "${ED}" -name '*.la' -exec rm -f {} +

	# punt everything provided by SLOT="3"
	rm -rf \
		"${ED}"usr/include/${PN}-0.4/${PN}-glib \
		"${ED}"usr/lib*/girepository-1.0/Dbusmenu-0.4.typelib \
		"${ED}"usr/lib*/${PN}-glib* \
		"${ED}"usr/lib*/pkgconfig/dbusmenu-glib-0.4.pc \
		"${ED}"usr/lib*/dbusmenu-bench \
		"${ED}"usr/share/doc/${PN} \
		"${ED}"usr/share/gir-1.0/Dbusmenu-0.4.gir \
		"${ED}"usr/share/gtk-doc \
		"${ED}"usr/share/vala/vapi/Dbusmenu-0.4.vapi
}
