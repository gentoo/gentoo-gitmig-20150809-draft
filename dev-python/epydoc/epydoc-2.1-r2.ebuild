# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/epydoc/epydoc-2.1-r2.ebuild,v 1.8 2006/12/07 13:15:24 eroyf Exp $

inherit distutils

DESCRIPTION="tool for generating API documentation for Python modules, based on their docstrings"
HOMEPAGE="http://epydoc.sourceforge.net/"
SRC_URI="mirror://sourceforge/epydoc/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 m68k ~mips ~ppc ~ppc64 s390 sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="doc pdf"

RDEPEND="virtual/python
	pdf? ( virtual/tetex )"

src_install() {
	distutils_src_install
	doman ${S}/man/*
	use doc && dohtml -r ${S}/doc/*
}
