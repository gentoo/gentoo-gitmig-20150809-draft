# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/telepathy-logger/telepathy-logger-0.2.10-r1.ebuild,v 1.1 2011/08/21 12:04:18 nirbheek Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"

inherit base python virtualx

DESCRIPTION="Telepathy Logger is a session daemon that should be activated whenever telepathy is being used."
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Logger"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-linux"
IUSE="doc +introspection"

RDEPEND=">=dev-libs/glib-2.25.11:2
	>=sys-apps/dbus-1.1
	>=dev-libs/dbus-glib-0.82
	>=net-libs/telepathy-glib-0.14.0
	dev-libs/libxml2
	dev-libs/libxslt
	dev-db/sqlite:3
	introspection? ( >=dev-libs/gobject-introspection-0.9.6 )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1.10 )
"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	base_src_prepare
	python_convert_shebangs -r 2 .
}

src_configure() {
	econf \
		$(use_enable doc gtk-doc) \
		--enable-debug \
		--enable-public-extensions \
		--disable-coding-style-checks \
		--disable-Werror \
		--disable-static
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	mkdir -p "${T}/home/cache"
	export XDG_CACHE_HOME="${T}/home/cache"
	Xemake check || die "make check failed"
}

src_install() {
	base_src_install
	dodoc AUTHORS ChangeLog NEWS README || die
	find "${ED}" -name "*.la" -delete || die "la files removal failed"
}
