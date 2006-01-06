# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/johntheripper/johntheripper-1.6.38.ebuild,v 1.4 2006/01/06 12:25:51 grobian Exp $

inherit eutils flag-o-matic toolchain-funcs

MY_PBASE=${P/theripper/}
S=${WORKDIR}/${MY_PBASE}
DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/john/"
SRC_URI="http://www.openwall.com/john/c/${MY_PBASE}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE="mmx"

RDEPEND="virtual/libc"

DEPEND="${RDEPEND}"


src_compile() {
	cd src
	# Note this program uses AS and LD incorrectly
	OPTIONS="CPP=$(tc-getCXX) CC=$(tc-getCC) AS=$(tc-getCC) LD=$(tc-getCC)"

	if use x86 ; then
		if use mmx ; then
			emake ${OPTIONS} linux-x86-mmx-elf || die "Make failed"
		elif is-flag "-march=k6-3" || is-flag "-march=k6-2" \
			|| is-flag "-march=k6"; then
			emake ${OPTIONS} linux-x86-k6-elf || die "Make failed"
		else
			emake ${OPTIONS} linux-x86-any-elf || die "Make failed"
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
		emake ${OPTIONS} macosx-ppc32-altivec-cc || die "Make failed"
		# for Tiger this can be macosx-ppc64-cc
	elif use ppc; then
		emake ${OPTIONS} linux-ppc  || die "Make failed"
	else
		emake ${OPTIONS} generic || die "Make failed"
	fi

	# currently broken
	#emake bench || die "make failed"
}


src_test() {
	cd run
	./john --test || die 'self test failed'
}

src_install() {
	# config files
	insinto /etc/john
	doins run/john.conf

	# executables
	dosbin run/john
	newsbin run/mailer john-mailer

	dosym john /usr/sbin/unafs
	dosym john /usr/sbin/unique
	dosym john /usr/sbin/unshadow

	# for EGG only
	dosym john /usr/sbin/undrop

	#newsbin src/bench john-bench

	# documentation
	dodoc doc/*
}
