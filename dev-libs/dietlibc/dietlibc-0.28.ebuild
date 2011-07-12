# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dietlibc/dietlibc-0.28.ebuild,v 1.12 2011/07/12 03:55:13 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="A minimal libc"
HOMEPAGE="http://www.fefe.de/dietlibc/"
SRC_URI="mirror://kernel/linux/libs/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~mips ppc ppc64 sparc x86"
IUSE="debug"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/0.24-dirent-prototype.patch
	epatch "${FILESDIR}"/gcc-33-r3.patch
	epatch "${FILESDIR}"/dietlibc-sparc64-makefile.patch #45601

	filter-flags -fstack-protector -fstack-protector-all

	# Ok so let's make dietlibc ssp aware (Aug 7 2004) -solar
	cp ${FILESDIR}/ssp.c "${S}"/lib/ || die "Failed to copy ssp.c into lib for compile"
	epatch "${FILESDIR}"/dietlibc-0.26-ssp.patch

	replace-sparc64-flags #45716

	# Fix for not available gcc option on hppa (20 Jul 2005) KillerFox
	test-flag -fno-stack-protector && append-flags -D__dietlibc__ -fno-stack-protector-all -fno-stack-protector
	epatch "${FILESDIR}"/dietlibc-0.28-Makefile.patch
}

src_compile() {
	local make_opt=""
	use debug && make_opt="DEBUG=1"
	emake CFLAGS="${CFLAGS}" ${make_opt} || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dobin "${D}"/usr/diet/bin/* || die "dobin"
	doman "${D}"/usr/diet/man/*/* || die "doman"
	rm -r "${D}"/usr/diet/{man,bin}
	dodoc AUTHOR BUGS CAVEAT CHANGES README THANKS TODO PORTING
}
