# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/libsecret/libsecret-0.10.ebuild,v 1.1 2012/09/25 10:06:41 tetromino Exp $

EAPI="4"

inherit gnome2 virtualx

DESCRIPTION="GObject library for accessing the freedesktop.org Secret Service API"
HOMEPAGE="https://live.gnome.org/Libsecret"

LICENSE="LGPL-2.1+ Apache-2.0" # Apache-2.0 license is used for tests only
SLOT="0"
IUSE="+crypt debug +introspection"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="
	>=dev-libs/glib-2.31.0:2
	crypt? ( >=dev-libs/libgcrypt-1.2.2 )
	introspection? ( >=dev-libs/gobject-introspection-1.29 )"
RDEPEND="${COMMON_DEPEND}
	>=gnome-base/gnome-keyring-3"
# Add ksecrets to RDEPEND when it's added to portage
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	sys-devel/gettext
	dev-util/gdbus-codegen
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="
		--enable-manpages
		--disable-strict
		--disable-coverage
		--disable-static
		--disable-vala
		$(use_enable crypt gcrypt)"
}

src_prepare() {
	gnome2_src_prepare
}

src_test() {
	Xemake check
}

src_install() {
	gnome2_src_install
	prune_libtool_files --all
}
