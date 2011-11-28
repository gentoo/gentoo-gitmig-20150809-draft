# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libappindicator/libappindicator-0.4.1-r201.ebuild,v 1.3 2011/11/28 15:12:01 ssuominen Exp $

EAPI=4

PYTHON_DEPEND="2:2.7"

inherit autotools eutils python

PN_vala_version=0.14

DESCRIPTION="A library to allow applications to export a menu into the Unity Menu bar"
HOMEPAGE="http://launchpad.net/libappindicator"
SRC_URI="http://launchpad.net/${PN}/${PV%.*}/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection"

# FIXME: Missing dev-lang/mono handling!
RDEPEND="dev-libs/dbus-glib
	>=dev-libs/glib-2.26
	dev-libs/libdbusmenu[gtk,-gtk3]
	>=dev-libs/libindicator-0.4:0
	dev-python/pygobject:2
	>=dev-python/pygtk-2.14:2
	>=x11-libs/gtk+-2.18:2
	introspection? ( >=dev-libs/gobject-introspection-0.10 )"
DEPEND="${RDEPEND}
	dev-lang/vala:${PN_vala_version}[vapigen]
	dev-util/gtk-doc-am
	dev-util/pkgconfig"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -i -e '/LDFLAGS/s:python2.6:python2.7:' bindings/python/Makefile.{am,in} || die
	epatch "${FILESDIR}"/${P}-no-mono.patch
	eautoreconf

	rm -f py-compile
	ln -s $(type -P true) py-compile
}

src_configure() {
	export VALAC="$(type -P valac-${PN_vala_version})"

	econf \
		--disable-static \
		--with-gtk=2
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	find "${ED}"usr -name '*.la' -exec rm -f {} +

	# SLOT="3" has eveything required
	rm -rf "${ED}"usr/share/gtk-doc
}

pkg_postinst() {
	python_mod_optimize appindicator
}

pkg_postrm() {
	python_mod_cleanup appindicator
}
