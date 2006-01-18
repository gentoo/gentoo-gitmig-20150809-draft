# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ice/ice-3.0.0.ebuild,v 1.1 2006/01/18 23:58:11 chriswhite Exp $

inherit eutils

MY_P=${PN/i/I}-${PV}

DESCRIPTION="ICE middleware C++ bindings"
HOMEPAGE="http://www.zeroc.com/index.html"
SRC_URI="http://www.zeroc.com/download/Ice/3.0/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="readline test"

DEPEND=""
RDEPEND=">=sys-libs/db-4.3.29
		>=dev-libs/expat-1.9
		>=dev-libs/openssl-0.9.7
		>=app-arch/bzip2-1.0
		readline? ( sys-libs/ncurses
				   sys-libs/readline )
		test? ( >=dev-lang/python-2.2 )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	built_with_use db nocxx && die "DB must be compiled with C++ support!"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use amd64; then
		sed -i -e "s:^#LP64:LP64:g" ${S}/config/Make.rules \
		|| die "Failed to set lib64 directory"
	fi

	if ! use readline; then
		sed -i -e "s#   USE_READLINE.*#   USE_READLINE := no#g" \
		${S}/config/Make.rules || die "Failed to set no readline"
	fi

	for files in ${S}/src/Freeze*/*.{h,cpp}
	do
		sed -i -e "s:db_cxx\.h:db4.3/db_cxx\.h:g" \
		${files} || die "Failed to patch db headers."
	done

	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	emake || die "Make failed."
}

src_test() {
	make test || die "Test failed!"
}

src_install() {
	make DESTDIR="${D}" install || die "Install Failed!"

cat <<- EOF > ${S}/50-${PN}
		LDPATH="/opt/${MY_P}/$(get_libdir)"
		ROOTPATH="/opt/${MY_P}/bin"
		PATH="/opt/${MY_P}/bin"
EOF
	doenvd ${S}/50-${PN}
}
