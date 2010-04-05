# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywebkitgtk/pywebkitgtk-1.1.7.ebuild,v 1.9 2010/04/05 17:42:36 armin76 Exp $

EAPI="2"
PYTHON_DEPEND="2"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"
SUPPORT_PYTHON_ABIS="1"

inherit python

DESCRIPTION="Python bindings for the WebKit GTK+ port"
HOMEPAGE="http://code.google.com/p/pywebkitgtk/"
SRC_URI="http://pywebkitgtk.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

RDEPEND="dev-python/pygobject:2
	dev-python/pygtk:2
	dev-python/sexy-python
	x11-libs/libsexy
	dev-libs/libxslt
	>=net-libs/webkit-gtk-1.1.15"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
RESTRICT_PYTHON_ABIS="3.*"

src_install() {
	python_src_install

	dodoc AUTHORS MAINTAINERS NEWS README || die "dodoc failed"
}
