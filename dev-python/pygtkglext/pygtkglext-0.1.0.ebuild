# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtkglext/pygtkglext-0.1.0.ebuild,v 1.1 2003/05/05 10:28:51 liquidx Exp $

DESCRIPTION="Python bindings to GtkGLExt"
HOMEPAGE="http://gtkglext.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkglext/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.2
	>=dev-python/pygtk-1.99
	>=dev-libs/glib-2.0
	>=x11-libs/gtk+-2.0
	>=x11-libs/gtkglext-0.99.1"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README COPYING* AUTHORS ChangeLog
	insinto /usr/share/doc/${PF}/examples
	doins examples/*.py
}
