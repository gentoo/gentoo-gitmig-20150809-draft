# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/bpython/bpython-0.9.2.ebuild,v 1.1 2009/06/07 10:46:56 grozin Exp $

EAPI=2
inherit distutils
DESCRIPTION="Curses interface to python"
HOMEPAGE="http://www.bpython-interpreter.org/"
SRC_URI="http://www.bpython-interpreter.org/releases/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-python/pygments
	dev-python/pyparsing"
RDEPEND="${DEPEND}"
DOCS="sample.ini"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}"/${P}.patch
}
