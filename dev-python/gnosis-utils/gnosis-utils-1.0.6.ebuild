# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnosis-utils/gnosis-utils-1.0.6.ebuild,v 1.1 2003/05/10 13:45:13 liquidx Exp $

inherit distutils

IUSE=""
MY_P=${P/gnosis-utils/Gnosis_Utils}

S=${WORKDIR}/${MY_P}

DESCRIPTION="XML pickling and objectification with Python."
SRC_URI="http://www.gnosis.cx/download/${MY_P}.tar.gz"
HOMEPAGE="http://www.gnosis.cx/download/"

DEPEND="virtual/python"

SLOT="0"
KEYWORDS="~x86"
LICENSE="PYTHON"


src_compile() {
	python setup_gnosis.py build || die
}

src_install() {
	distutils_python_version

	python setup_gnosis.py install --root=${D} || die

	dodir /usr/share/doc/${PF}
	dodoc README MANIFEST PKG-INFO

	if [ -e "${D}/usr/lib/python${PYVER}/site-packages/gnosis/doc" ] ; then
		einfo "Moving documentation to correct location"
		mv ${D}/usr/lib/python${PYVER}/site-packages/gnosis/doc ${D}/usr/share/doc/${PF}/doc
	fi
	
	rm -f ${D}/usr/lib/python${PYVER}/site-packages/gnosis/{README,MANIFEST}
	rm -f ${D}/usr/lib/python${PYVER}/site-packages/{README,MANIFEST}	
}
