# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libvirt-glib/libvirt-glib-0.0.6.ebuild,v 1.1 2012/03/07 15:38:15 cardoe Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 python

DESCRIPTION="GLib and GObject mappings for libvirt"
HOMEPAGE="http://libvirt.org/git/?p=libvirt-glib.git"
SRC_URI="ftp://libvirt.org/libvirt/glib/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +introspection python +vala"
REQUIRED_USE="vala? ( introspection )"

# 0.9.8 is needed for VIR_DOMAIN_EVENT_SHUTDOWN
RDEPEND="
	dev-libs/libxml2:2
	>=app-emulation/libvirt-0.9.8
	>=dev-libs/glib-2.10:2
	introspection? ( >=dev-libs/gobject-introspection-0.10.8 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.10 )
	vala? ( dev-lang/vala:0.14 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="--disable-test-coverage
		VAPIGEN=$(type -P vapigen-0.14)
		$(use_enable introspection)
		$(use_enable vala)
		$(use_with python)"

	python_set_active_version 2
	python_pkg_setup
}
