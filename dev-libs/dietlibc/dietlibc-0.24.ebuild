# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dietlibc/dietlibc-0.24.ebuild,v 1.7 2004/03/25 16:15:15 weeve Exp $

inherit eutils flag-o-matic fixheadtails gcc

DESCRIPTION="A minimal libc"
HOMEPAGE="http://www.fefe.de/dietlibc/"
SRC_URI="mirror://kernel/linux/libs/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~hppa ~amd64 ~alpha ~ppc"
IUSE=""

DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch "${FILESDIR}/${PV}-dirent-prototype.patch"
	[ $(gcc-major-version) -eq 3 ] && epatch "${FILESDIR}/gcc-33.patch"

	# depending on glibc to provide guard symbols, does not work with -nostdlib building
	filter-flags "-fstack-protector"
	filter-flags "fstack-protector-all"

	sed -i \
		-e "s:^CFLAGS.*:CFLAGS = ${CFLAGS}:" \
		-e "s:^prefix.*:prefix=/usr/diet:" \
		-e "s:^#DESTDIR=.*:DESTDIR=${D}:" Makefile || \
			die "sed Makefile failed"

	# New fix for sparc64 and dietlibc, fixes bug #45601
	[ "${PROFILE_ARCH}" = "sparc64" ] && \
		epatch ${FILESDIR}/dietlibc-sparc64-makefile.patch

	ht_fix_all
}

src_compile() {
	filter-flags "-fstack-protector"

	emake || die "emake failed"
}

src_install() {
	make install || die "make install failed"

	exeinto /usr/bin
	newexe bin-$(uname -m | sed -e 's/i[4-9]86/i386/' -e 's/armv[3-6][lb]/arm/' -e 's/sparc64/sparc/')/diet-i diet || die "newexe failed"

	doman diet.1 || die "doman failed"
	dodoc AUTHOR BUGS CAVEAT CHANGES README THANKS TODO PORTING || \
		die "dodoc failed"
}
