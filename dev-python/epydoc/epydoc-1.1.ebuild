# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/epydoc/epydoc-1.1.ebuild,v 1.6 2003/08/07 02:33:54 vapier Exp $

inherit distutils

DESCRIPTION="tool for generating API documentation for Python modules, based on their docstrings"
HOMEPAGE="http://epydoc.sourceforge.net/"
SRC_URI="mirror://sourceforge/epydoc/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"

RDEPEND="virtual/python"

src_install() {
	distutils_src_install

	# copy docs (using cp -r cuz of some sub-dirs)
	cp -r ${S}/doc/* ${D}/usr/share/doc/${PF}/
	prepalldocs
	doman ${S}/man/*
}
