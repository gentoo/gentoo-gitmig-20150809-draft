# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyzor/pyzor-0.4.0.ebuild,v 1.1 2002/12/12 23:01:30 blauwers Exp $

DESCRIPTION="Pyzor is a distributed, collaborative spam detection and filtering network"
HOMEPAGE="http://pyzor.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyzor/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/python
	sys-libs/gdbm"
RDEPEND=${DEPEND}

inherit distutils

src_install () {
	mydoc="INSTALL NEWS PKG-INFO THANKS UPGRADING docs/usage.html"
	distutils_src_install

	rm -rf ${D}/usr/share/doc/pyzor

	#chmod -R a+rX \
		#${D}/usr/share/doc/pyzor \
        	#${D}/usr/lib/python2.2/site-packages/pyzor \
                #${D}/usr/bin/pyzor \
		#${D}/usr/bin/pyzord

}
