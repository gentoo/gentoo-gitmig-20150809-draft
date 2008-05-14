# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-4.7.1.ebuild,v 1.8 2008/05/14 17:24:12 hawking Exp $

NEED_PYTHON=2.3

inherit python toolchain-funcs versionator multilib

MY_P=${P/_}

DESCRIPTION="SIP is a tool for generating bindings for C++ classes so that they can be used by Python."
HOMEPAGE="http://www.riverbankcomputing.co.uk/sip/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="sip"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="debug"

S=${WORKDIR}/${MY_P}

DEPEND=""
RDEPEND=""

src_compile(){
	python_version

	local myconf
	use debug && myconf="${myconf} -u"

	python configure.py \
		-b "/usr/bin" \
		-d "/usr/$(get_libdir)/python${PYVER}/site-packages" \
		-e "/usr/include/python${PYVER}" \
		-v "/usr/share/sip" \
		${myconf} \
		CXXFLAGS_RELEASE="" CFLAGS_RELEASE="" \
		CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" \
		CC=$(tc-getCC) CXX=$(tc-getCXX) \
		LINK=$(tc-getCXX) LINK_SHLIB=$(tc-getCXX) \
		STRIP="true" || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog NEWS README THANKS TODO doc/sipref.txt
	dohtml doc/*
}

pkg_postinst() {
	python_mod_optimize
}

pkg_postrm() {
	python_mod_cleanup
}
