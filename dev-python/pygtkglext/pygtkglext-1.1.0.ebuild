# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtkglext/pygtkglext-1.1.0.ebuild,v 1.2 2007/04/23 14:50:18 gustavoz Exp $

inherit python eutils

DESCRIPTION="Python bindings to GtkGLExt"
HOMEPAGE="http://gtkglext.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkglext/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=dev-python/pygtk-2.8
	>=dev-libs/glib-2.0
	>=x11-libs/gtk+-2.0
	>=x11-libs/gtkglext-1.0.0
	dev-python/pyopengl
	virtual/opengl
	virtual/glu"

src_install() {
	make DESTDIR=${D} install || die
	dodoc README AUTHORS ChangeLog
	insinto /usr/share/doc/${PF}/examples
	doins examples/*.py
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/lib/python${PYVER}/site-packages/gtk-2.0
}

pkg_postrm() {
	python_mod_cleanup
}
