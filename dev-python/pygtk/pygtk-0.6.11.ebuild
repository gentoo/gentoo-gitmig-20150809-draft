# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygtk/pygtk-0.6.11.ebuild,v 1.16 2004/07/10 16:37:55 lucass Exp $

DESCRIPTION="GTK+ bindings for Python"
HOMEPAGE="http://www.pygtk.org/"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/python/v1.2/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1.2"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

DEPEND="virtual/python
	>=gnome-base/libglade-0.17-r6
	>=media-libs/imlib-1.8
	>=media-libs/gdk-pixbuf-0.9.0
	=x11-libs/gtk+-1.2*"

src_install() {
	einstall || die
}
