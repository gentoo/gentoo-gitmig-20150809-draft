# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-4.1.1.ebuild,v 1.4 2004/12/09 17:39:08 gustavoz Exp $

inherit distutils

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
HOMEPAGE="http://www.riverbankcomputing.co.uk/sip/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc ~alpha ~amd64 ~ppc64"
IUSE="doc"

DEPEND="virtual/libc
	x11-libs/qt
	>=dev-lang/python-2.3"

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
	if use doc ; then dohtml doc/* ; fi
}

pkg_postinst() {
	einfo "Please note, that you have to emerge PyQt again, when upgrading from sip-3.x."
}
