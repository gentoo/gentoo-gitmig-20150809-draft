# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/PyQt-3.8.1.ebuild,v 1.3 2003/12/16 17:04:19 liquidx Exp $

inherit eutils distutils

IUSE=""

S="${WORKDIR}/PyQt-x11-gpl-${PV}"

DESCRIPTION="set of Python bindings for the QT 3.x Toolkit"
SRC_URI="mirror://gentoo/PyQt-x11-gpl-${PV}.tar.gz"
#SRC_URI="http://www.river-bank.demon.co.uk/download/PyQt/PyQt-x11-gpl-${PV}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/pyqt/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

PV_MAJOR=${PV/.*/}
PV_MINOR=${PV#${PV_MAJOR}.}
PV_MINOR=${PV_MINOR/.*}

DEPEND="virtual/glibc
	sys-devel/libtool
	x11-libs/qt
	dev-lang/python
	=dev-python/sip-${PV_MAJOR}.${PV_MINOR}*
	>=dev-python/qscintilla-1.53"

src_unpack() {
	unpack PyQt-x11-gpl-${PV}.tar.gz
	cd ${S}
	epatch $FILESDIR/license-${PV}.diff
}

src_compile() {

	distutils_python_version
	# standard qt sandbox problem workaround
	[ -d "$QTDIR/etc/settings" ] && addwrite "$QTDIR/etc/settings"
	dodir /usr/lib/python${PYVER}/site-packages
	dodir /usr/include/python${PYVER}
	python build.py \
		-d ${D}/usr/lib/python${PYVER}/site-packages \
		-e /usr/include/python${PYVER} \
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
