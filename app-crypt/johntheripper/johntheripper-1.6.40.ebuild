# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/johntheripper/johntheripper-1.6.40.ebuild,v 1.7 2007/04/04 17:59:50 phreak Exp $

inherit eutils flag-o-matic toolchain-funcs

MY_PBASE=${P/theripper/}
S=${WORKDIR}/${MY_PBASE}
DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/john/ http://www.banquise.net/misc/patch-john.html"
SRC_URI="http://www.openwall.com/john/c/${MY_PBASE}.tar.gz
		mirror://gentoo/${MY_PBASE}-banquise-to-bigpatch-17.patch.bz2"

# banquise-to-bigpatch-17.patch.bz2"
# based off /var/tmp/portage/johntheripper-1.6.40

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="mmx sse2 altivec"

RDEPEND="virtual/libc"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	epatch ${MY_PBASE}-banquise-to-bigpatch-17.patch
	epatch ${FILESDIR}/clk_tck.patch
	sed -i -e "s|^CFLAGS.*|CFLAGS= -c -Wall ${CFLAGS}|" \
		-e 's|^LDFLAGS =\(.*\)|LDFLAGS =\1 -lm|' "${MY_PBASE}"/src/Makefile
}


src_compile() {
	cd src
	# Note this program uses AS and LD incorrectly
	OPTIONS="CPP=$(tc-getCXX) CC=$(tc-getCC) AS=$(tc-getCC) LD=$(tc-getCC) \
		OPT_NORMAL= OPT_INLINE= JOHN_SYSTEMWIDE=1"

	if use x86 ; then
		if use sse2 ; then
			emake ${OPTIONS} linux-x86-sse2 || die "Make failed"
		elif use mmx ; then
			emake ${OPTIONS} linux-x86-mmx || die "Make failed"
		else
			emake ${OPTIONS} linux-x86-any || die "Make failed"
		fi
	elif use alpha ; then
		emake ${OPTIONS} linux-alpha || die "Make failed"
	elif use sparc; then
		emake ${OPTIONS} linux-sparc  || die "Make failed"
	elif use amd64; then
		if use mmx; then
			emake ${OPTIONS} linux-x86-64-mmx  || die "Make failed"
		else
			emake ${OPTIONS} linux-x86-64  || die "Make failed"
		fi
	elif use ppc-macos; then
		if use altivec; then
			emake ${OPTIONS} macosx-ppc32-altivec || die "Make failed"
		else
			emake ${OPTIONS} macosx-ppc32 || die "Make failed"
		fi
		# for Tiger this can be macosx-ppc64
	elif use ppc64; then
		if use altivec; then
			emake ${OPTIONS} linux-ppc32-altivec  || die "Make failed"
		else
			emake ${OPTIONS} linux-ppc64  || die "Make failed"
		fi
		# linux-ppc64-altivec is slightly slower than linux-ppc32-altivec for most hash types.
		# as per the Makefile comments
	elif use ppc; then
		if use altivec; then
			emake ${OPTIONS} linux-ppc32-altivec  || die "Make failed"
		else
			emake ${OPTIONS} linux-ppc32 || die "Make failed"
		fi
	else
		emake ${OPTIONS} generic || die "Make failed"
	fi

	# currently broken
	#emake bench || die "make failed"
}


src_test() {
	cd run
	if  [[ -f /etc/john/john.conf || -f /etc/john/john.ini  ]]
	then
		./john --test || die 'self test failed'
	else
		ewarn "selftest requires /etc/john/john.conf or /etc/john/john.ini"
	fi
	ewarn "WPA PSK failes on MMX and SSE2 - see"
	ewarn "http://www.banquise.net/misc/patch-john.html"
}

src_install() {
	# config files
	insinto /etc/john
	doins run/john.conf
	sed -i -e 's:$JOHN:/usr/share/john:g' "${D}/etc/john/john.conf"

	# executables
	dosbin run/john
	newsbin run/mailer john-mailer

	dosym john /usr/sbin/unafs
	dosym john /usr/sbin/unique
	dosym john /usr/sbin/unshadow

	# for EGG only
	dosym john /usr/sbin/undrop

	#newsbin src/bench john-bench

	# share
	insinto /usr/share/john/
	doins run/*.chr run/password.lst

	# documentation
	dodoc doc/*
}
