# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dietlibc/dietlibc-0.27.ebuild,v 1.2 2004/12/05 19:25:40 solar Exp $

inherit eutils flag-o-matic fixheadtails gcc

DESCRIPTION="A minimal libc"
HOMEPAGE="http://www.fefe.de/dietlibc/"
SRC_URI="mirror://kernel/linux/libs/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~hppa ~amd64 ~mips"
IUSE="debug"

DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/0.24-dirent-prototype.patch"
	# wanted for gcc3.3 and gcc3.4 - robbat2 (Oct 01 2004)
	[ $(gcc-major-version) -le 3 ] \
		&& epatch ${FILESDIR}/gcc-33-r2.patch
#		&& epatch ${FILESDIR}/${PV}-gcc34.patch

	# depending on glibc to provide guard symbols, does not work with -nostdlib
	# building
	filter-flags -fstack-protector -fstack-protector-all

	# ${FILESDIR}/ssp.c is integrated with upstream as of dietlibc-0.26
	# - robbat2 (Oct 01 2004)

	# Ok so let's make dietlibc ssp aware (Aug 7 2004) -solar
	# ${FILESDIR}/ssp.c does not appear to be integrated with
	# upstream as of dietlibc-0.27 bug 73112 - solar (Dec 05 2004)
	cp ${FILESDIR}/ssp.c ${S}/lib/ || die "Failed to copy ssp.c into lib for compile"

	# start with sparc/sparc64/x86_64/i386 for now.
	# apply to all arches for crazy cross-compiling - robbat2 (Oct 01 2004)
	epatch ${FILESDIR}/dietlibc-0.26-ssp.patch

	# Fix for 45716
	replace-sparc64-flags

	# be very careful to only effect the CFLAGS used for optimization
	# and not any of the other CFLAGS. - robbat2 (Oct 01 2004)

	# Shifted ssp exclusion logic into sed expression. - solar (Dec 05 2004)
	sed -i \
		-e "s:^CFLAGS+=-O -fomit-frame-pointer:CFLAGS += ${CFLAGS} -D__dietlibc__:" \
		-e "s:^CFLAGS=-pipe -nostdinc:CFLAGS=-pipe -nostdinc -D__dietlibc__ -fno-stack-protector-all -fno-stack-protector:" \
		-e "s:^prefix.*:prefix=/usr/diet:" \
		Makefile \
		|| die "sed Makefile failed"

	# New fix for sparc64 and dietlibc, fixes bug #45601
	# Apply to all arches for crazy cross-compiling - robbat2 (Oct 01 2004)
	epatch ${FILESDIR}/dietlibc-sparc64-makefile.patch

	ht_fix_all
}

src_compile() {
	local emake_opt=""
	use debug  && emake_opt='DEBUG=1'
	emake ${emake_opt} || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"

	exeinto /usr/bin
	newexe bin-$(uname -m | sed -e 's/i[4-9]86/i386/' -e 's/armv[3-9][lb]/arm/' -e 's/sparc64/sparc/')/diet-i diet || die "newexe failed"

	doman diet.1
	dodoc AUTHOR BUGS CAVEAT CHANGES README THANKS TODO PORTING
}
