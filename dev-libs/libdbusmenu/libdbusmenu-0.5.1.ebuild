# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdbusmenu/libdbusmenu-0.5.1.ebuild,v 1.2 2011/11/04 22:12:01 dilfridge Exp $

EAPI=4

inherit eutils versionator virtualx

MY_MAJOR_VERSION="$(get_version_component_range 1-2)"
if version_is_at_least "${MY_MAJOR_VERSION}.50" ; then
	MY_MAJOR_VERSION="$(get_major_version).$(($(get_version_component_range 2)+1))"
fi

DESCRIPTION="Library to pass menu structure across DBus"
HOMEPAGE="https://launchpad.net/dbusmenu"
SRC_URI="http://launchpad.net/dbusmenu/${MY_MAJOR_VERSION}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk gtk3 +introspection test vala"

RDEPEND="
	dev-libs/glib:2
	dev-libs/dbus-glib
	dev-libs/libxml2:2
	gtk? (
		gtk3? ( x11-libs/gtk+:3 )
		!gtk3? ( x11-libs/gtk+:2 )
	)
"

DEPEND="${RDEPEND}
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )
	test? (
		dev-libs/json-glib[introspection?]
		dev-util/dbus-test-runner
	)
	vala? ( dev-lang/vala:0.14 )
	app-text/gnome-doc-utils
	dev-util/intltool
	dev-util/pkgconfig
"

REQUIRED_USE="vala? ( introspection )"

src_configure() {
	local gtkconf
	if use gtk3 ; then
		gtkconf=" --with-gtk=3"
	else
		gtkconf=" --with-gtk=2"
	fi

	VALA_API_GEN=$(type -p vapigen-0.14) \
		econf \
		${gtkconf} \
		$(use_enable gtk) \
		$(use_enable gtk dumper) \
		$(use_enable introspection) \
		$(use_enable test tests) \
		$(use_enable vala)
}

src_test() {
	Xemake check || die "testsuite failed"
}

src_install() {
	MAKEOPTS="-j1" default
}
