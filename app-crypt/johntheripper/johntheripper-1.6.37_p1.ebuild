# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/johntheripper/johntheripper-1.6.37_p1.ebuild,v 1.3 2005/03/29 18:40:09 corsair Exp $

inherit eutils flag-o-matic toolchain-funcs

MY_P1=${P/theripper/}
MY_P=${MY_P1/_p?/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/john/"
SRC_URI="http://www.openwall.com/john/b/${MY_P}.tar.gz
	mirror://gentoo/${MY_P1}-gentoo.patch.bz2"

#
# john-{$PV}-gentoo.patch is a heavly hacked combination of:
#        mirror://debian/pool/main/j/john/${DEBPATCH}.gz
#'ftp://ftp.openwall.com/pub/projects/john/contrib/john-1.6.37-apache-md5v01.diff.gz'
#'ftp://ftp.openwall.com/pub/projects/john/contrib/john-1.6.37-eggpatch-11.diff.gz'
#'ftp://ftp.openwall.com/pub/projects/john/contrib/john-1.6.37-krb5-1.diff.gz'
#'ftp://ftp.openwall.com/pub/projects/john/contrib/john-1.6.37-macosx-ppc-altivec-1.diff.gz'
#'ftp://ftp.openwall.com/pub/projects/john/contrib/john-1.6.37-mysql-1.diff.gz'
#'ftp://ftp.openwall.com/pub/projects/john/contrib/john-1.6.37-nsldap-2.diff.gz'
#'ftp://ftp.openwall.com/pub/projects/john/contrib/john-1.6.37-raw-md5-1.diff.gz'
#'ftp://ftp.openwall.com/pub/projects/john/contrib/john-1.6-nsldaps4.diff.gz'
# ftp://ftp.openwall.com/pub/projects/john/contrib/john-ntlm-patch-v02.tgz
#        http://www.monkey.org/~dugsong/john-1.6.krb4.patch-3
#        http://www.monkey.org/~dugsong/john-1.6.skey.patch-1
#


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ppc ~alpha ~amd64 ppc64"

#KEYWORDS removed until "generic" target is fixed - "~mips ~hppa"
IUSE="mmx ntlm skey mysql krb4 kerberos"

# ldap - removed as it causes segfault when running

RDEPEND="virtual/libc
	skey? ( app-admin/skey )
	kerberos? ( dev-libs/openssl )"

DEPEND="${RDEPEND}
	sys-devel/binutils
	sys-devel/gcc"

src_unpack() {
	unpack ${A}
	epatch ${DISTDIR}/${MY_P1}-gentoo.patch.bz2 || die "patch failed"
}

src_compile() {
	cd src
	# Note this program uses AS and LD incorrectly
	local OPTIONS="CPP=$(tc-getCXX) CC=$(tc-getCC) AS=$(tc-getCC) LD=$(tc-getCC)"
	OPTIONS="${OPTIONS} EGG=true RAWMD5=true APACHE=true"
	use kerberos && OPTIONS="${OPTIONS} KERBEROS5=true"
	use krb4 && OPTIONS="${OPTIONS} KERBEROS4=true"
	use ntlm && OPTIONS="${OPTIONS} NTLM=true"
	use skey && OPTIONS="${OPTIONS} SKEY=true"
	use mysql && OPTIONS="${OPTIONS} MYSQL=true"
	# ldap broken - segfaults in selftest
	# use ldap && OPTIONS="${OPTIONS} LDAP=true"

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
	elif use ppc; then
		emake ${OPTIONS} linux-ppc  || die "Make failed"
	elif use amd64; then
		if use mmx; then
			emake ${OPTIONS} linux-x86-64-mmx  || die "Make failed"
		else
			emake ${OPTIONS} linux-x86-64  || die "Make failed"
		fi
	elif use ppc-macos; then
		emake ${OPTIONS} macosx-ppc-altivec-cc || die "Make failed"
		#emake ${OPTIONS} macosx-ppc-cc || die "Make failed"
	else
		emake ${OPTIONS} generic || die "Make failed"
	fi

	# currently broken
	#emake bench || die "make failed"
}


src_test() {
	einfo "S/KEY and Kerberos 4 known to fail selftest"
	run/john --test
}

src_install() {
	# config files
	insinto /etc
	doins run/john.conf debian/john-mail.msg debian/john-mail.conf

	# shared fies
	insinto /usr/share/john
	doins run/password.lst \
		debian/john-dailyscript \
		run/all.chr run/alpha.chr run/digits.chr run/lanman.chr

	# Man pages
	doman debian/*.1

	# executables
	dosbin run/john debian/john-cronjob debian/john-dailyscript
	newsbin debian/mailer john-mailer

	dosym john /usr/sbin/unafs
	dosym john /usr/sbin/unique
	dosym john /usr/sbin/unshadow

	# for EGG only
	dosym john /usr/sbin/undrop

	#newsbin src/bench john-bench

	# documentation
	dodoc debian/CONFIG.mailer doc/*
}
