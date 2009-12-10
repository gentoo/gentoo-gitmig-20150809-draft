# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywebkitgtk/pywebkitgtk-1.1.5.ebuild,v 1.2 2009/12/10 19:29:33 armin76 Exp $

EAPI="2"

NEED_PYTHON="2.4"

inherit python

DESCRIPTION="Python bindings for the WebKit GTK+ port."
HOMEPAGE="http://code.google.com/p/pywebkitgtk/"
SRC_URI="http://pywebkitgtk.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-python/pygobject:2
	dev-python/pygtk:2
	dev-python/sexy-python
	x11-libs/libsexy
	dev-libs/libxslt
	>=net-libs/webkit-gtk-1.1.5"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	python_need_rebuild

	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS MAINTAINERS NEWS README || die "dodoc failed"
}
