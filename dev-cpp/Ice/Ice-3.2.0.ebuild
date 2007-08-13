# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/Ice/Ice-3.2.0.ebuild,v 1.2 2007/08/13 09:03:55 caleb Exp $

inherit eutils

DESCRIPTION="ICE middleware C++ bindings"
HOMEPAGE="http://www.zeroc.com/index.html"
SRC_URI="http://www.zeroc.com/download/Ice/3.2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ncurses test debug"

RDEPEND=">=dev-libs/expat-2.0
	>=app-arch/bzip2-1.0.3
	>=dev-libs/openssl-0.9.8
	=sys-libs/db-4.5.20*"

DEPEND="${RDEPEND}
	ncurses? ( sys-libs/ncurses sys-libs/readline )
	test? ( >=dev-lang/python-2.4 )"

pkg_setup() {
	if built_with_use sys-libs/db nocxx; then
		eerror "sys-libs/db must be compiled with C++ support!"
		eerror "Remove the 'nocxx' use flag and try again."
		die "Fix use flags and re-emerge"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-Makefile.patch

	if use amd64; then
		sed -i -e "s:^#LP64:LP64:g" ${S}/config/Make.rules \
		|| die "Failed to set lib64 directory"
	fi

	if ! use ncurses; then
		sed -i -e "s#^USE_READLINE.*#USE_READLINE      ?= yes#g" \
		${S}/config/Make.rules || die "Failed to set no readline"
	fi

	if ! use debug; then
		sed -i -e "s:#OPTIMIZE:OPTIMIZE:" \
		${S}/config/Make.rules || die "Failed to remove debug"
	fi

	sed -i -e \
	"s:.*CXXFLAGS[^\+]*\=\s:CXXFLAGS = ${CXXFLAGS} :g" \
	${S}/config/Make.rules.Linux || die "CXXFLAGS patching failed!"
}

src_install() {
	make DESTDIR="${D}" install || die "Install Failed!"
}

src_test() {
	make test || die "Test failed"
}
