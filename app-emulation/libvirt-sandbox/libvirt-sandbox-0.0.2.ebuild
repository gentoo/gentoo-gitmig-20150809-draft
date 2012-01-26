# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libvirt-sandbox/libvirt-sandbox-0.0.2.ebuild,v 1.1 2012/01/26 07:54:58 nirbheek Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Library for building application sandboxes using libvirt"
HOMEPAGE="http://libvirt.org/git/?p=libvirt-sandbox.git"
SRC_URI="ftp://libvirt.org/libvirt/sandbox/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +introspection static-libs"

RDEPEND="
	>=dev-libs/glib-2.28:2
	>=app-emulation/libvirt-glib-0.0.4
	introspection? ( >=dev-libs/gobject-introspection-0.10.8 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	doc? ( >=dev-util/gtk-doc-1.10 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="--disable-test-coverage
		$(use_enable static-libs static)
		$(use_enable introspection)"
}
