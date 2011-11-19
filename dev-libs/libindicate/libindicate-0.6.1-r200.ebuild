# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicate/libindicate-0.6.1-r200.ebuild,v 1.1 2011/11/19 17:13:52 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"

inherit autotools eutils python

__vala_version=0.14

DESCRIPTION="A library to raise flags on DBus for other components of the desktop to pick up and visualize"
HOMEPAGE="http://launchpad.net/libindicate"
SRC_URI="http://launchpad.net/${PN}/${PV%.*}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection"

RDEPEND=">=dev-libs/dbus-glib-0.76
	>=dev-libs/glib-2.18:2
	>=dev-libs/libdbusmenu-0.3.97[introspection?]
	dev-libs/libxml2:2
	dev-python/pygtk:2
	>=x11-libs/gtk+-2.12:2
	introspection? ( dev-libs/gobject-introspection )"
DEPEND="${RDEPEND}
	gnome-base/gnome-common
	app-text/gnome-doc-utils
	dev-util/gtk-doc-am
	dev-util/pkgconfig
	dev-lang/vala:${__vala_version}[vapigen]"

RESTRICT="test" # for -no-mono.patch

DOCS=( AUTHORS ChangeLog )

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-no-mono.patch

	sed -i -e 's:-Werror::' {examples,libindicate,libindicate-gtk}/Makefile.{am,in} || die

	# for slotted dev-lang/vala
	sed -i -e "s:vapigen:vapigen-${__vala_version}:" configure.ac || die

	eautoreconf

	rm -f py-compile
	ln -s $(type -P true) py-compile
}

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		--disable-static \
		$(use_enable introspection) \
		--with-gtk=2 \
		--with-html-dir=/usr/share/doc/${PF}
}

src_install() {
	default
	find "${ED}"usr -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	python_mod_optimize indicate
}

pkg_postrm() {
	python_mod_cleanup indicate
}
