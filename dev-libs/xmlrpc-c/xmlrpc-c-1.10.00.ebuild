# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlrpc-c/xmlrpc-c-1.10.00.ebuild,v 1.1 2007/05/22 14:26:29 hollow Exp $

inherit eutils

DESCRIPTION="A lightweigt RPC library based on XML and HTTP"
SRC_URI="mirror://sourceforge/xmlrpc-c/${P}.tgz"
HOMEPAGE="http://xmlrpc-c.sourceforge.net/"

KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="curl libwww threads"
LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-libs/libxml2
	libwww? ( net-libs/libwww )
	curl? ( net-misc/curl )"

pkg_setup() {
	if ! use curl && ! use libwww; then
		ewarn "Neither CURL nor libwww support was selected"
		ewarn "No client library will be be built"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm -f "${S}"/GNUmakefile
	epatch "${FILESDIR}"/${PN}-1.10.00-cmake.patch

	epatch "${FILESDIR}"/${PN}-1.05-pic.patch
	epatch "${FILESDIR}"/${PN}-1.06.02-threadupdatestatus.patch
	epatch "${FILESDIR}"/${PN}-1.10.00-mutexcreate.patch
}

src_compile() {
	local myconf=(
		"-D ENABLE_LIBXML2_BACKEND:BOOL=1"
		"-D MUST_BUILD_WININET_CLIENT:BOOL=0"
		"-D CMAKE_INSTALL_PREFIX:PATH=/usr"
	)

	if use threads; then
		myconf=( "${myconf[@]}" "-D ENABLE_ABYSS_THREADS:BOOL=1" )
	else
		myconf=( "${myconf[@]}" "-D ENABLE_ABYSS_THREADS:BOOL=0" )
	fi

	if use curl; then
		myconf=( "${myconf[@]}" "-D MUST_BUILD_CURL_CLIENT:BOOL=1" )
	else
		myconf=( "${myconf[@]}" "-D MUST_BUILD_CURL_CLIENT:BOOL=0" )
	fi

	if use libwww; then
		myconf=( "${myconf[@]}" "-D MUST_BUILD_LIBWWW_CLIENT:BOOL=1" )
	else
		myconf=( "${myconf[@]}" "-D MUST_BUILD_LIBWWW_CLIENT:BOOL=0" )
	fi

	cmake ${myconf[@]} . || die "cmake failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
