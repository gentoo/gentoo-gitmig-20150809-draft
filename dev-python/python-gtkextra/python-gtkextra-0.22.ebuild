# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-gtkextra/python-gtkextra-0.22.ebuild,v 1.3 2004/10/22 03:54:00 pythonhead Exp $

inherit distutils


DESCRIPTION="Python bindings for gtk+extra"
HOMEPAGE="http://python-gtkextra.sourceforge.net/"
SRC_URI="mirror://sourceforge/python-gtkextra/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="=x11-libs/gtk+-1.2.10*
	=dev-python/pygtk-0.6*
	>=dev-python/numeric-22.0
	>=x11-libs/gtk+extra-0.99.17"
DOCS="AUTHORS TODO NEWS THANKS"

src_install() {
	distutils_src_install
	dodir /usr/share/doc/${PF}/examples
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
}

