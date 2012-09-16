# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libosinfo/libosinfo-0.2.0.ebuild,v 1.2 2012/09/16 00:58:19 tetromino Exp $

EAPI=4
VALA_MIN_API_VERSION="0.16"
VALA_USE_DEPEND="vapigen"

inherit eutils toolchain-funcs vala

DESCRIPTION="GObject library for managing information about real and virtual OSes"
HOMEPAGE="http://fedorahosted.org/libosinfo/"
SRC_URI="http://fedorahosted.org/releases/${PN:0:1}/${PN:1:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +introspection +vala test"

REQUIRED_USE="vala? ( introspection )"

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/libxslt-1.0.0
	dev-libs/libxml2
	net-libs/libsoup:2.4
	net-libs/libsoup-gnome:2.4
	introspection? ( >=dev-libs/gobject-introspection-0.9.0 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.10 )
	test? ( dev-libs/check )
	vala? ( $(vala_depend) )"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	use vala && vala_src_prepare
}

src_configure() {
	local udevdir=/lib/udev
	has_version sys-fs/udev && udevdir="$($(tc-getPKG_CONFIG) --variable=udevdir udev)"

	# --enable-udev is only for rules.d file install
	econf \
		--disable-static \
		--disable-silent-rules \
		$(use_enable doc gtk-doc) \
		$(use_enable test tests) \
		$(use_enable introspection) \
		$(use_enable vala) \
		--enable-udev \
		--disable-coverage \
		--with-udev-rulesdir="${udevdir}"/rules.d \
		--with-html-dir=/usr/share/doc/${PF}/html
}

src_install() {
	default
	prune_libtool_files
}
