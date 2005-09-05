# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/epydoc/epydoc-2.1-r1.ebuild,v 1.2 2005/09/05 17:36:27 weeve Exp $

inherit distutils

DESCRIPTION="tool for generating API documentation for Python modules, based on their docstrings"
HOMEPAGE="http://epydoc.sourceforge.net/"
SRC_URI="mirror://sourceforge/epydoc/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~ia64 ~ppc ~sparc ~x86"
IUSE="pdf"

RDEPEND="virtual/python
	pdf? ( virtual/tetex )"

src_install() {
	distutils_src_install

	# copy docs (using cp -r cuz of some sub-dirs)
	cp -r ${S}/doc/* ${D}/usr/share/doc/${PF}/
	prepalldocs
	doman ${S}/man/*
}
