# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyqwt/pyqwt-5.0.1.ebuild,v 1.3 2008/01/02 14:14:59 armin76 Exp $

inherit eutils

MY_P=PyQwt-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Python bindings for the Qwt library"
SRC_URI="mirror://sourceforge/pyqwt/${MY_P}.tar.gz"
HOMEPAGE="http://pyqwt.sourceforge.net/"

SLOT="5"
LICENSE="GPL-2"
KEYWORDS="~ia64 ~x86"
IUSE="debug doc examples"

DEPEND="virtual/python
	=x11-libs/qwt-5*
	>=dev-python/PyQt4-4.2
	>=dev-python/sip-4.1.1
	>=dev-python/numpy-1.0.1"

src_compile() {
        cd ${S}/sip/qwt5qt4
	# PyQwt CVS does not need the next 2 sed statements anymore
        sed -i "s|%Import QtSvg/QtSvgmod.sip||" QwtModule.sip
        sed -i "s|%Include qwt_plot_svgitem.sip||" QwtModule.sip
	cd "${S}/configure"
	local myconf="-I /usr/include/qwt5 -l qwt --disable-numarray --disable-numeric"
	use debug && myconf="${myconf} --debug"
	has distcc ${FEATURES} || myconf="${myconf} -j 1"
	python configure.py ${myconf}
	emake || die "emake failed"
}

src_install() {
	cd "${S}/configure"
	make DESTDIR="${D}" install || die "make install failed"
	cd "${S}"
	dodoc ANNOUNCEMENT-${PV} CHANGES-${PV} COPYING* README
        use doc && dohtml Doc/html/pyqwt/*
        if use examples ; then
                dodir /usr/share/doc/${PF}/examples
                cp -r qt4examples/ "${D}/usr/share/doc/${PF}/examples"
        fi
}
