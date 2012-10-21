# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ucommon/ucommon-5.2.2-r3.ebuild,v 1.4 2012/10/21 13:23:53 pinkbyte Exp $

EAPI="4"

inherit autotools-utils

DESCRIPTION="Portable C++ runtime for threads and sockets"
HOMEPAGE="http://www.gnu.org/software/commoncpp"
SRC_URI="mirror://gnu/commoncpp/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 ~x86 ~amd64-linux"
IUSE="doc static-libs socks +cxx debug ssl gnutls"

RDEPEND="ssl? ( dev-libs/openssl )
	gnutls? ( net-libs/gnutls )"

DEPEND="virtual/pkgconfig
	doc? ( app-doc/doxygen )
	${RDEPEND}"

DOCS=(README NEWS SUPPORT ChangeLog AUTHORS)
PATCHES=( "${FILESDIR}"/disable_rtf_gen_doxy.patch
		  "${FILESDIR}/${P}-address.patch")
AUTOTOOLS_IN_SOURCE_BUILD=1

REQUIRED_USE="^^ ( ssl gnutls )"

src_configure() {
	local myconf=""
	if ! use ssl && ! use gnutls; then
		myconf=" --with-sslstack=nossl "
	fi

	if use ssl; then
		myconf=" --with-sslstack=ssl "
		ewarn "Using openssl for ssl stack"
	fi

	if use gnutls; then
		myconf=" --with-sslstack=gnu "
		ewarn "Using gnutls for ssl stack"
	fi

	local myeconfargs=(
		$(use_enable  socks)
		$(use_enable  cxx stdcpp)
		${myconf}
		--enable-atomics
		--with-pkg-config
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	use doc && autotools-utils_src_compile doxy
}

src_install() {
	autotools-utils_src_install
	if use doc; then
		dohtml doc/html/*
	fi
}
