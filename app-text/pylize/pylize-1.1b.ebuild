# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pylize/pylize-1.1b.ebuild,v 1.6 2004/07/19 22:14:05 kloeri Exp $

DESCRIPTION="Python HTML Slideshow Generator using HTML and CSS"
HOMEPAGE="http://www.chrisarndt.de/en/software/pylize/"
SRC_URI="http://www.chrisarndt.de/en/software/pylize/download/${P}.tar.bz2"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/python
	dev-python/imaging
	>=dev-python/htmlgen-2.2.2"

src_compile() {
	einfo "no need to compile"
}

src_install() {
	python install.py ${D}/usr || die

	# Fix Data dir in code
	cat ${D}/usr/bin/pylize | sed -e "s:^sys_libdir.*:sys_libdir = \'/usr/share/pylize\':" > ${D}/usr/bin/pylize.new || die
	mv ${D}/usr/bin/pylize.new ${D}/usr/bin/pylize || die
	chmod 755 ${D}/usr/bin/pylize

	PYTHON_VER=$(python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:')
	insinto /usr/lib/python${PYTHON_VER}/site-packages
	doins lib/roman.py
}
