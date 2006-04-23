# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-4.4.2.ebuild,v 1.1 2006/04/23 17:07:02 carlo Exp $

inherit distutils

MY_P=${P/"?.?.?_pre"/"snapshot-"}
MY_P=${MY_P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
HOMEPAGE="http://www.riverbankcomputing.co.uk/sip/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
#SRC_URI="http://www.riverbankcomputing.com/Downloads/sip4/${MY_P}.tar.gz"
#SRC_URI="http://www.riverbankcomputing.com/Downloads/Snapshots/sip4//${MY_P}.tar.gz"

SLOT="0"
LICENSE="sip"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ppc64"
IUSE="debug doc"

DEPEND="virtual/libc
	x11-libs/qt
	>=dev-lang/python-2.3"

src_compile(){
	distutils_python_version

	local myconf="-b ${ROOT}/usr/bin -d ${ROOT}/usr/$(get_libdir)/python${PYVER}/site-packages -e ${ROOT}/usr/include/python${PYVER} -v ${ROOT}/usr/share/sip"
	use debug && myconf="${myconf} -u"

	python configure.py ${myconf} "CFLAGS+=${CFLAGS}" "CXXFLAGS+=${CXXFLAGS}"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc ChangeLog LICENSE NEWS README THANKS TODO
	if use doc ; then dohtml doc/* ; fi
}
