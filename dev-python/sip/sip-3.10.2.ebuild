# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-3.10.2.ebuild,v 1.7 2004/07/18 17:19:33 weeve Exp $

inherit distutils

DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
HOMEPAGE="http://www.riverbankcomputing.co.uk/sip/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc alpha"
IUSE=""

DEPEND="virtual/libc
	x11-libs/qt
	virtual/python"

src_compile(){
	distutils_python_version
	python configure.py -l qt-mt \
		-b /usr/bin \
		-d /usr/lib/python${PYVER}/site-packages \
		-e /usr/include/python${PYVER} \
		"CXXFLAGS+=${CXXFLAGS}"
	emake || die
}

src_install() {
	einstall DESTDIR=${D} || die
	dodoc ChangeLog LICENSE NEWS README THANKS TODO
}

pkg_postinst() {
	einfo "Please note, that you have to emerge PyQt again, when upgrading from an earlier sip-3.x version."
}
