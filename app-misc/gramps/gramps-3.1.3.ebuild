# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gramps/gramps-3.1.3.ebuild,v 1.1 2009/12/25 00:01:35 fauli Exp $

EAPI=2

inherit autotools eutils gnome2 python

DESCRIPTION="Genealogical Research and Analysis Management Programming System"
HOMEPAGE="http://www.gramps-project.org/"
SRC_URI="mirror://sourceforge/gramps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="gnome mozembed reports spell webkit"

RDEPEND=">=dev-lang/python-2.5
	dev-python/bsddb3
	>=dev-python/pygtk-2.10.0
	x11-misc/xdg-utils
	gnome-base/librsvg:2
	gnome? ( dev-python/libgnome-python
		dev-python/gconf-python )
	mozembed? ( dev-python/gtkmozembed-python )
	spell? ( dev-python/gtkspell-python
		dev-python/pyenchant )
	reports? ( media-gfx/graphviz )
	webkit? ( dev-python/pywebkitgtk )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/libiconv
	dev-util/pkgconfig"

DOCS="NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} --disable-mime-install"
}

src_prepare() {
	gnome2_src_prepare
	eautoreconf

	epatch "${FILESDIR}"/${PN}-3.1.2-use_bsddb3.patch
	# This is for bug 215944, so .pyo/.pyc files don't get into the
	# file system
	mv "${S}"/py-compile "${S}"/py-compile.orig
	ln -s $(type -P true) "${S}"/py-compile

	python_version

	# Fix install path.
	einfo "Fix installation path"
	find . -iname 'Makefile.in' | xargs \
		sed "s;\(pkgdatadir = \)\(\$(datadir)\);\1$(python_get_sitedir);" -i \
		|| die

	sed "s;\$(prefix)/share/gramps;/$(python_get_sitedir)/@PACKAGE@;" \
		-i src/Makefile.in || die

	sed "s;\$(prefix)/share/gramps;/$(python_get_sitedir)/@PACKAGE@;" \
	-i src/docgen/Makefile.in || die

	einfo "Fix wrapper script"
	sed "s;@datadir@;$(python_get_sitedir);" \
		-i gramps.sh.in || die

	einfo "Fix icon location"
	sed "s;gramps/;pixmap/;g" -i data/gramps.keys.in || die
}

src_install() {
	python_need_rebuild
	gnome2_src_install
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize $(python_get_sitedir)/${PN}
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_version
	python_mod_cleanup $(python_get_sitedir)/${PN}
}
