# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyXML/PyXML-0.8.2.ebuild,v 1.1 2003/04/24 22:16:15 liquidx Exp $

IUSE=""

inherit distutils

DESCRIPTION="A collection of libraries to process XML with Python."
SRC_URI="mirror://sourceforge/pyxml/${P}.tar.gz"
HOMEPAGE="http://pyxml.sourceforge.net/"

DEPEND="virtual/python
	>=dev-libs/expat-1.95.6"

SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
LICENSE="PYTHON"

src_compile() {
	local myconf
	
	# if you want to use 4Suite, then their XSLT/XPATH is
	# better according to the docs
	if has_version "dev-python/4Suite"; then
		myconf="--without-xslt --without-xpath"
	fi
	
	distutils_src_compile ${myconf}
}

src_install() {

	mydoc="ANNOUNCE CREDITS PKG-INFO doc/*.tex"
	distutils_src_install

	dohtml -r doc/*

}
