# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/iripdb/iripdb-0.1.3b.ebuild,v 1.2 2005/02/19 16:16:26 swegener Exp $

inherit eutils flag-o-matic toolchain-funcs

MY_P=${P/iripdb/iRipDB}
S=${WORKDIR}/${PN}

DESCRIPTION="iRipDB allows generating the DB files necessary for the iRiver iHP-1xx series of MP3/Ogg HD Player on Linux and Windows."
HOMEPAGE="http://www.fataltourist.com/iripdb/"
SRC_URI="http://www.fataltourist.com/iripdb/${MY_P}.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""
DEPEND="virtual/libc
	media-libs/taglib
	sys-libs/zlib"

pkg_setup() {
	if test_version_info 3.3
	then
		einfo "Using gcc 3.3*"
		# gcc 3.3 doesn't support certain 3.4.1 options,
		#  as well as having less specific -march options
		replace-flags -march=pentium-m -march=pentium3
		filter-flags -march=k8
		filter-flags -march=athlon64
		filter-flags -march=opteron
		strip-unsupported-flags
	elif test_version_info 3.4
	then
		einfo "Using gcc 3.4*"
	fi
}

src_compile() {
	echo "$(tc-getCXX) ${CXXFLAGS} -c -o main.o main.cpp"
	$(tc-getCXX) ${CXXFLAGS} -c -o main.o -I/usr/include/taglib main.cpp
	echo "$(tc-getCC) ${CFLAGS} -o iripdb main.o -lz -lm -ltag -lstdc++"
	$(tc-getCC) ${CFLAGS} -o iripdb main.o -lz -lm -ltag -lstdc++
}

src_install() {
	dobin iripdb
	dodoc AUTHORS README doc/iRivDB_structure
}

