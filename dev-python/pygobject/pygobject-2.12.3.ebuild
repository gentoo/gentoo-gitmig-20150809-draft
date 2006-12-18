# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygobject/pygobject-2.12.3.ebuild,v 1.5 2006/12/18 14:45:38 gustavoz Exp $

WANT_AUTOMAKE=1.8

inherit gnome2 python eutils autotools

DESCRIPTION="GNOME 2 bindings for Python"
HOMEPAGE="http://www.pygtk.org/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ~ppc64 ~sh sparc x86"
IUSE="doc"

RDEPEND=">=dev-lang/python-2.3.5
	>=dev-libs/glib-2.8
	!<dev-python/pygtk-2.9"
DEPEND="${RDEPEND}
	doc? ( dev-libs/libxslt >=app-text/docbook-xsl-stylesheets-1.70.1 )
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"


pkg_setup() {
	G2CONF="$(use_enable doc docs)"
}

src_unpack() {
	gnome2_src_unpack

	# fix bug #147285 - Robin H. Johnson <robbat2@gentoo.org>
	# this is caused by upstream's automake-1.8 lacking some Gentoo-specific
	# patches (for tmpfs amongst other things). Upstreams hit by this should
	# move to newer automake versions ideally.
	eautomake

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s /bin/true py-compile
}

src_install() {
	gnome2_src_install

	insinto /usr/share/doc/${P}
	doins -r examples

	python_version
	mv ${D}/usr/$(get_libdir)/python${PYVER}/site-packages/pygtk.py \
		${D}/usr/$(get_libdir)/python${PYVER}/site-packages/pygtk.py-2.0
	mv ${D}/usr/$(get_libdir)/python${PYVER}/site-packages/pygtk.pth \
		${D}/usr/$(get_libdir)/python${PYVER}/site-packages/pygtk.pth-2.0
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/gtk-2.0
	alternatives_auto_makesym /usr/$(get_libdir)/python${PYVER}/site-packages/pygtk.py pygtk.py-[0-9].[0-9]
	alternatives_auto_makesym /usr/$(get_libdir)/python${PYVER}/site-packages/pygtk.pth pygtk.pth-[0-9].[0-9]
	python_mod_compile /usr/$(get_libdir)/python${PYVER}/site-packages/pygtk.py
}

pkg_postrm() {
	python_version
	python_mod_cleanup
}
