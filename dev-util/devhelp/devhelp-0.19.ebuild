# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devhelp/devhelp-0.19.ebuild,v 1.5 2008/04/21 19:22:30 maekke Exp $

inherit toolchain-funcs gnome2 python

DESCRIPTION="An API documentation browser for GNOME 2"
HOMEPAGE="http://developer.imendio.com/wiki/Devhelp"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="xulrunner zlib"

RDEPEND=">=gnome-base/gconf-2.6
	>=x11-libs/gtk+-2.8
	>=dev-libs/glib-2.8
	>=gnome-base/libglade-2.4
	>=x11-libs/libwnck-2.10
	xulrunner? ( =net-libs/xulrunner-1.8* )
	!xulrunner? ( =www-client/mozilla-firefox-2* )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	  sys-devel/gettext
	>=dev-util/intltool-0.35.5
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README"

src_unpack() {
	gnome2_src_unpack

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

pkg_setup() {
	G2CONF="$(use_with zlib)"

	if use xulrunner ; then
		G2CONF="${G2CONF} --with-gecko=xulrunner"
	else
		G2CONF="${G2CONF} --with-gecko=firefox"
	fi

	# ICC is crazy, silence warnings (bug #154010)
	if [[ $(tc-getCC) == "icc" ]] ; then
		G2CONF="${G2CONF} --with-compile-warnings=no"
	fi
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/gedit-2/plugins/devhelp
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
