# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-4.1.1.ebuild,v 1.9 2005/07/26 21:54:47 kloeri Exp $

inherit distutils

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
HOMEPAGE="http://www.riverbankcomputing.co.uk/sip/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc ~ppc64 sparc x86"
IUSE="debug doc"

DEPEND="virtual/libc
	x11-libs/qt
	>=dev-lang/python-2.3"

src_compile(){
	distutils_python_version

	local myconf="-l qt-mt -b /usr/bin -d /usr/$(get_libdir)/python${PYVER}/site-packages -e /usr/include/python${PYVER}"
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
	einfo "Please note, that you have to emerge PyQt again, when upgrading from sip-3.x."
	echo ""
}
