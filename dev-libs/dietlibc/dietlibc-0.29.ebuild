# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dietlibc/dietlibc-0.29.ebuild,v 1.2 2006/01/07 08:23:28 phreak Exp $

inherit eutils flag-o-matic

DESCRIPTION="A minimal libc"
HOMEPAGE="http://www.fefe.de/dietlibc/"
SRC_URI="mirror://kernel/linux/libs/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/0.24-dirent-prototype.patch
	# No longer needed with 0.29
	#epatch "${FILESDIR}"/gcc-33-r3.patch
	epatch "${FILESDIR}"/dietlibc-sparc64-makefile.patch #45601

	filter-flags -fstack-protector -fstack-protector-all

	# Ok so let's make dietlibc ssp aware (Aug 7 2004) -solar
	cp ${FILESDIR}/ssp.c "${S}"/lib/ || die "Failed to copy ssp.c into lib for compile"
	epatch "${FILESDIR}"/dietlibc-0.26-ssp.patch

	replace-sparc64-flags #45716

	# Fix for a non-available gcc option on hppa (20 Jul 2005) KillerFox
	test_flag -fno-stack-protector && \
		append-flags -D__dietlibc__ -fno-stack-protector-all -fno-stack-protector
	epatch "${FILESDIR}"/dietlibc-0.28-Makefile.patch
}

src_compile() {
	local make_opt=

	use debug && make_opt="DEBUG=1"

	# Fix a compilation problem using the 32-bit userland with 64-bit kernel on
	# PowerPC, because with that configuration, dietlibc detects a ppc64 system.
	# -- hansmi, 2005-09-04
	use ppc && sed -i -e 's/^MYARCH:=.*$/MYARCH=ppc/' Makefile

	emake CFLAGS="${CFLAGS}" ${make_opt} || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dobin "${D}"/usr/diet/bin/* || die "dobin"
	doman "${D}"/usr/diet/man/*/* || die "doman"
	rm -r "${D}"/usr/diet/{man,bin}
	dodoc AUTHOR BUGS CAVEAT CHANGES README THANKS TODO PORTING
}
