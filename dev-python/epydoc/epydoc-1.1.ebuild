# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/epydoc/epydoc-1.1.ebuild,v 1.2 2003/02/13 11:34:02 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION=" Epydoc is a tool for generating API documentation for Python modules, based on their docstrings."
SRC_URI="mirror://sourceforge/epydoc/${P}.tar.gz"
HOMEPAGE="http://epydoc.sourceforge.net/"
LICENSE="MIT"
SLOT="0"
RDEPEND="virtual/python"
DEPEND="$DEPEND"
KEYWORDS="~x86"
IUSE=""

inherit distutils

src_install() {
    distutils_src_install

    # copy docs (using cp -r cuz of some sub-dirs)
    cp -r ${S}/doc/* ${D}/usr/share/doc/${P}/
    
    # man-pages
    doman ${S}/man/*
   
}

