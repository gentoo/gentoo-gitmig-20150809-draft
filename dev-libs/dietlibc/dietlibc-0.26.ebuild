# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dietlibc/dietlibc-0.26.ebuild,v 1.1 2004/07/18 07:59:15 dragonheart Exp $

inherit eutils flag-o-matic fixheadtails gcc

DESCRIPTION="A minimal libc"
HOMEPAGE="http://www.fefe.de/dietlibc/"
SRC_URI="mirror://kernel/linux/libs/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~hppa ~amd64"
IUSE=""

DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/0.24-dirent-prototype.patch"
	[ $(gcc-major-version) -eq 3 ] \
		&& epatch ${FILESDIR}/gcc-33.patch

#		&& epatch ${FILESDIR}/${PV}-gcc34.patch

	# depending on glibc to provide guard symbols, does not work with -nostdlib building
	filter-flags -fstack-protector -fstack-protector-all

	# Fix for 45716
	replace-sparc64-flags

	sed -i \
		-e "s:^CFLAGS.*:CFLAGS = ${CFLAGS}:" \
		-e "s:^prefix.*:prefix=/usr/diet:" \
		-e "s:^#DESTDIR=.*:DESTDIR=${D}:" \
		Makefile \
		|| die "sed Makefile failed"

	# New fix for sparc64 and dietlibc, fixes bug #45601
	[ "${PROFILE_ARCH}" = "sparc64" ] && \
		epatch ${FILESDIR}/dietlibc-sparc64-makefile.patch

	ht_fix_all
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make install || die "make install failed"

	exeinto /usr/bin
	newexe bin-$(uname -m | sed -e 's/i[4-9]86/i386/' -e 's/armv[3-6][lb]/arm/' -e 's/sparc64/sparc/')/diet-i diet || die "newexe failed"

	doman diet.1
	dodoc AUTHOR BUGS CAVEAT CHANGES README THANKS TODO PORTING
}
