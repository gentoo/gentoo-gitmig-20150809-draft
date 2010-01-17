# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pylize/pylize-1.3b.ebuild,v 1.3 2010/01/17 13:44:51 fauli Exp $

inherit python

DESCRIPTION="Python HTML Slideshow Generator using HTML and CSS"
HOMEPAGE="http://www.chrisarndt.de/en/software/pylize/"
SRC_URI="http://www.chrisarndt.de/en/software/pylize/download/${P}.tar.bz2"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"

DEPEND="virtual/python
	dev-python/empy
	dev-python/imaging"

src_compile() {
	einfo "no need to compile"
}

src_install() {
	python install.py ${D}/usr || die

	# Fix Data dir in code
	sed -e "s:^sys_libdir.*:sys_libdir = \'/usr/share/pylize\':" -i ${D}/usr/bin/pylize

	python_version
	insinto /usr/lib/python${PYVER}/site-packages
	doins lib/roman.py

	dodoc COPYING Changelog README README.empy TODO
}
