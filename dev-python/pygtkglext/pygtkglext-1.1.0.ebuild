# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtkglext/pygtkglext-1.1.0.ebuild,v 1.16 2007/08/15 04:17:51 jer Exp $

NEED_PYTHON="2.3"

inherit python multilib

DESCRIPTION="Python bindings to GtkGLExt"
HOMEPAGE="http://gtkglext.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkglext/${P}.tar.bz2"
LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 ~sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-python/pygtk-2.8
	>=dev-libs/glib-2.0
	>=x11-libs/gtk+-2.0
	>=x11-libs/gtkglext-1.0.0
	dev-python/pyopengl
	virtual/opengl
	virtual/glu"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS ChangeLog

	insinto /usr/share/doc/${PF}/examples
	doins examples/*.{py,png}
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/gtk-2.0
}

pkg_postrm() {
	python_version
	python_mod_cleanup /usr/$(get_libdir)/python${PYVER}/site-packages/gtk-2.0
}
