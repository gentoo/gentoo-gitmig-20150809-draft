# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/epydoc/epydoc-2.0.ebuild,v 1.3 2004/05/04 11:44:07 kloeri Exp $

inherit distutils

DESCRIPTION="tool for generating API documentation for Python modules, based on their docstrings"
HOMEPAGE="http://epydoc.sourceforge.net/"
SRC_URI="mirror://sourceforge/epydoc/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 alpha ia64"
IUSE=""

RDEPEND="virtual/python"

src_install() {
	distutils_src_install

	# copy docs (using cp -r cuz of some sub-dirs)
	cp -r ${S}/doc/* ${D}/usr/share/doc/${PF}/
	prepalldocs
	doman ${S}/man/*
}
