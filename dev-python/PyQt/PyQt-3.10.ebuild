# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/PyQt/PyQt-3.10.ebuild,v 1.1 2004/01/18 01:06:05 pythonhead Exp $

inherit distutils

IUSE=""
MY_P="PyQt-x11-gpl-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="set of Python bindings for the QT 3.x Toolkit"
SRC_URI="http://www.river-bank.demon.co.uk/download/PyQt/${MY_P}.tar.gz"
HOMEPAGE="http://www.riverbankcomputing.co.uk/pyqt/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
PV_MAJOR=${PV/.*/}
PV_MINOR=${PV#${PV_MAJOR}.}
PV_MINOR=${PV_MINOR/.*}

DEPEND="virtual/glibc
	sys-devel/libtool
	x11-libs/qt
	dev-lang/python
	>=dev-python/sip-${PV_MAJOR}.${PV_MINOR}
	>=dev-python/qscintilla-1.54"

src_compile() {
	distutils_python_version
	# standard qt sandbox problem workaround
	[ -d "$QTDIR/etc/settings" ] && addwrite "$QTDIR/etc/settings"
	dodir /usr/lib/python${PYVER}/site-packages /usr/include/python${PYVER} /usr/bin /usr/share/sip
	cd ${S}
	sed -i -e "s/  check_license()/# check_license()/" configure.py
	python configure.py \
		-d ${D}usr/lib/python${PYVER}/site-packages \
		-b ${D}usr/bin \
		-v ${D}usr/share/sip \
		-c
	make || die
}

src_install() {
	make install || die
	dodoc ChangeLog LICENSE NEWS README README.Linux README.SunOS THANKS
	dodir /usr/share/doc/${P}/
	mv ${D}/usr/share/doc/* ${D}/usr/share/doc/${P}/
	insinto /usr/share/sip
	doins ${S}/sip/*
	echo "/${D//\//\\/}/s//\//" > fixpaths.sed
	sed -i -f fixpaths.sed ${D}usr/lib/python${PYVER}/site-packages/pyqtconfig.py
}
