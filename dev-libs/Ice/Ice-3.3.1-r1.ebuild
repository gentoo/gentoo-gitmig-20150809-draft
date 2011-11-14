# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/Ice/Ice-3.3.1-r1.ebuild,v 1.3 2011/11/14 11:22:34 flameeyes Exp $

EAPI=2

inherit eutils

DESCRIPTION="ICE middleware C++ bindings"
HOMEPAGE="http://www.zeroc.com/index.html"
SRC_URI="http://www.zeroc.com/download/Ice/3.3/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ncurses test debug"

RDEPEND=">=dev-libs/expat-2.0.1
	>=app-arch/bzip2-1.0.4
	>=dev-libs/openssl-0.9.8g
	=sys-libs/db-4.6.21*[cxx]
	=dev-cpp/libmcpp-2.7.2"

DEPEND="${RDEPEND}
	ncurses? ( sys-libs/ncurses sys-libs/readline )
	test? ( >=dev-lang/python-2.4 )"

S=${WORKDIR}/${P}/cpp

src_prepare() {
	epatch "${FILESDIR}"/${P}-Makefile.patch
	epatch "${FILESDIR}"/${P}-openssl.patch

	MAKE_RULES="${S}/config/Make.rules"

	#if use amd64; then
	#	sed -i -e "s:^#LP64:LP64:g" "${MAKE_RULES}" \
	#	|| die "Failed to set lib64 directory"
	#fi

	if ! use ncurses; then
		sed -i -e "s#^USE_READLINE.*#USE_READLINE      ?= yes#g" \
		"${MAKE_RULES}" || die "Failed to set no readline"
	fi

	if ! use debug; then
		sed -i -e "s:#OPTIMIZE:OPTIMIZE:" \
		"${MAKE_RULES}" || die "Failed to remove debug"
	fi

	sed -i -e \
	"s:.*CXXFLAGS[^\+]*\=\s:CXXFLAGS = ${CXXFLAGS} :g" \
	"${MAKE_RULES}.Linux" || die "CXXFLAGS patching failed!"
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	cp -dpR "${S}"/../slice "${D}"/usr/share/Ice
}

src_test() {
	emake test || die "Test failed"
}
