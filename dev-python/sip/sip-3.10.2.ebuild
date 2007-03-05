# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-3.10.2.ebuild,v 1.11 2007/03/05 03:08:01 genone Exp $

inherit distutils

DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
HOMEPAGE="http://www.riverbankcomputing.co.uk/sip/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="sip"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

DEPEND="virtual/libc
	x11-libs/qt
	virtual/python"

src_compile(){
	distutils_python_version
	python configure.py -l qt-mt \
		-b ${ROOT}/usr/bin \
		-d ${ROOT}/usr/lib/python${PYVER}/site-packages \
		-e ${ROOT}/usr/include/python${PYVER} \
		"CXXFLAGS+=${CXXFLAGS}"
	emake || die
}

src_install() {
	einstall DESTDIR=${D} || die
	dodoc ChangeLog LICENSE NEWS README THANKS TODO
}

pkg_postinst() {
	elog "Please note, that you have to emerge PyQt again, when upgrading from an earlier sip-3.x version."
}
