# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/PyQt-3.5-r1.ebuild,v 1.1 2003/02/17 17:39:39 danarmak Exp $

S="${WORKDIR}/PyQt-x11-gpl-${PV}"
DESCRIPTION="PyQt is a set of Python bindings for the QT 3.x Toolkit"
SRC_URI="http://www.river-bank.demon.co.uk/download/PyQt/PyQt-x11-gpl-${PV}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/pyqt/"

SLOT="0"
LICENSE="GPL"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/glibc
	sys-devel/libtool
	>=x11-libs/qt-3.0.4.1
    	>=dev-lang/python-2.2.1
    	=dev-python/sip-${PV}"

src_unpack() {

        unpack PyQt-x11-gpl-${PV}.tar.gz
        cd ${S}
        patch -p0 < ${FILESDIR}/license-3.5.diff

}


src_compile() {
	dodir /usr/lib/python2.2/site-packages
	dodir /usr/include/python2.2
	python build.py \
		-d ${D}/usr/lib/python2.2/site-packages \
		-e /usr/include/python2.2 \
		-b ${D}/usr/bin \
		-l qt-mt -c
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README.Linux NEWS LICENSE README ChangeLog THANKS
	dodir /usr/share/doc/${P}/
	mv ${D}/usr/share/doc/* ${D}/usr/share/doc/${P}/ 
	# I found out this location from the redhat rpm
	insinto /usr/share/sip/qt
	doins ${S}/sip/*
}
