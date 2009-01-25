# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gramps/gramps-3.0.4.ebuild,v 1.6 2009/01/25 16:41:45 armin76 Exp $

EAPI=2
NEED_PYTHON="2.5"
WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit autotools eutils gnome2 python

DESCRIPTION="Genealogical Research and Analysis Management Programming System"
HOMEPAGE="http://www.gramps-project.org/"
SRC_URI="mirror://sourceforge/gramps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE="reports"

RDEPEND=">=dev-python/pygtk-2.10.0
	|| ( dev-python/libgnome-python
		>=dev-python/gnome-python-2.22.0
		>=dev-python/gnome-python-desktop-2.6 )
	reports? ( media-gfx/graphviz )"
DEPEND="${RDEPEND}
	|| ( dev-lang/python[sqlite] dev-lang/python[berkdb] )
	sys-devel/gettext
	virtual/libiconv
	dev-util/pkgconfig"

DOCS="NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} --disable-mime-install"
}

src_unpack() {
	gnome2_src_unpack
	epatch "${FILESDIR}"/${PN}-3.0.3_fix-installation-race-condition.patch
	eautoreconf
	# This is for bug 215944, so .pyo/.pyc files don't get into the
	# file system
	mv "${S}"/py-compile "${S}"/py-compile.orig
	ln -s $(type -P true) "${S}"/py-compile
}

src_install() {
	python_need_rebuild
	gnome2_src_install
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup /usr/share/${PN}
}
