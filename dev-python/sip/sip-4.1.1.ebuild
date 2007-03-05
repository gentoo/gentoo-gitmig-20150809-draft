# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-4.1.1.ebuild,v 1.12 2007/03/05 03:08:01 genone Exp $

inherit distutils

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
HOMEPAGE="http://www.riverbankcomputing.co.uk/sip/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

SLOT="0"
LICENSE="sip"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="debug doc"

DEPEND="virtual/libc
	x11-libs/qt
	>=dev-lang/python-2.3"

src_compile(){
	distutils_python_version

	local myconf="-l qt-mt -b ${ROOT}usr/bin -d ${ROOT}usr/$(get_libdir)/python${PYVER}/site-packages -e ${ROOT}usr/include/python${PYVER}"
	use debug && myconf="${myconf} -u"

	python configure.py ${myconf} "CFLAGS+=${CFLAGS}" "CXXFLAGS+=${CXXFLAGS}"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc ChangeLog LICENSE NEWS README THANKS TODO
	if use doc ; then dohtml doc/* ; fi
}

pkg_postinst() {
	echo ""
	elog "Please note, that you have to emerge PyQt again, when upgrading from sip-3.x."
	echo ""
}
