# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/iripdb/iripdb-0.1.1.ebuild,v 1.5 2004/12/03 11:44:00 slarti Exp $

S=${WORKDIR}/iRipDB-${PV}

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="iRipDB allows generating the DB files necessary for the iRiver iHP-1xx series of MP3/Ogg HD Player on Linux and Windows."
HOMEPAGE="http://www.marevalo.net/iRipDB"
SRC_URI="http://www.marevalo.net/iRipDB/iRipDB-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""
DEPEND="virtual/libc
	=media-libs/id3lib-3.8.3*
	=media-libs/libogg-1.1*
	=media-libs/libvorbis-1.0.1*
	=sys-libs/zlib-1.2.1*"

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
	echo "$(tc-getCC) ${CFLAGS} -c -o main.o main.c"
	$(tc-getCC) ${CFLAGS} -c -o main.o main.c
	echo "$(tc-getCC) ${CFLAGS} -c -o vcedit.o vcedit.c"
	$(tc-getCC) ${CFLAGS} -c -o vcedit.o vcedit.c
	echo "$(tc-getCC) ${CFLAGS} -o iripdb main.o vcedit.o -lz -lm -lid3 -lvorbis -logg -lstdc++"
	$(tc-getCC) ${CFLAGS} -o iripdb main.o vcedit.o -lz -lm -lid3 -lvorbis -logg -lstdc++
}

src_install() {
	dobin iripdb
	dodoc AUTHORS README doc/iRivDB_structure
}

