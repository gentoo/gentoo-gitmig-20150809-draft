# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/pessulus/pessulus-2.30.2.ebuild,v 1.7 2010/09/20 15:26:25 mr_bones_ Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit gnome2 python

DESCRIPTION="Lockdown editor for GNOME"
HOMEPAGE="http://live.gnome.org/Pessulus"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-python/pygtk-2.13.0
	dev-python/pygobject
	>=dev-python/libbonobo-python-2.22
	>=dev-python/bug-buddy-python-2.22
	>=dev-python/gconf-python-2.17.2
	>=gnome-base/gconf-2"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	sys-devel/gettext
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README TODO"

src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	mv "${S}"/py-compile "${S}"/py-compile.orig
	ln -s $(type -P true) "${S}"/py-compile
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_need_rebuild
	python_mod_optimize $(python_get_sitedir)/Pessulus
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/Pessulus
}
