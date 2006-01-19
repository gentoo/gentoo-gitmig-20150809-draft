# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/ice/ice-3.0.0-r1.ebuild,v 1.1 2006/01/19 15:35:47 caleb Exp $

inherit eutils

MY_P=${PN/i/I}-${PV}

DESCRIPTION="ICE middleware C++ bindings"
HOMEPAGE="http://www.zeroc.com/index.html"
SRC_URI="http://www.zeroc.com/download/Ice/3.0/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="readline test"

DEPEND="readline? ( sys-libs/ncurses
				   sys-libs/readline )
		test? ( >=dev-lang/python-2.2 )
		>=sys-libs/db-4.3.29
		>=dev-libs/openssl-0.9.7"
RDEPEND=">=dev-libs/expat-1.9
		>=app-arch/bzip2-1.0"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	built_with_use db nocxx && die "DB must be compiled with C++ support!"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-makefile.patch

	if use amd64; then
		sed -i -e "s:^#LP64:LP64:g" ${S}/config/Make.rules \
		|| die "Failed to set lib64 directory"
	fi

	if ! use readline; then
		sed -i -e "s#   USE_READLINE.*#   USE_READLINE := no#g" \
		${S}/config/Make.rules || die "Failed to set no readline"
	fi

	sed -i -e \
	"s:.*CXXFLAGS[^\+]*\=\s:CXXFLAGS = ${CXXFLAGS} :g" \
	${S}/config/Make.rules.Linux || die "CXXFLAGS patching failed!"

	for files in ${S}/src/Freeze*/*.{h,cpp}
	do
		sed -i -e "s:db_cxx\.h:db4.3/db_cxx\.h:g" \
		${files} || die "Failed to patch db headers."
	done
}

src_install() {
	make DESTDIR="${D}" install || die "Install Failed!"
}
