# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/johntheripper/johntheripper-1.6.37-r1.ebuild,v 1.7 2004/11/28 19:05:56 blubb Exp $

inherit eutils flag-o-matic

MY_P=${P/theripper/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/john/"
SRC_URI="http://www.openwall.com/john/b/${MY_P}.tar.gz
	mirror://gentoo/${PF/theripper/}-gentoo.patch.bz2"

#
# john-{$PV}-gentoo.patch is a heavly hacked combination of:
#        mirror://debian/pool/main/j/john/${DEBPATCH}.gz
#        ftp://ftp.openwall.com/pub/projects/john/contrib/john-ntlm-patch-v02.tgz
#        http://www.monkey.org/~dugsong/john-1.6.krb4.patch-3
#        http://www.monkey.org/~dugsong/john-1.6.skey.patch-1
#        ftp://ftp.openwall.com/pub/projects/john/contrib/john-1.6-mysql-1.diff
#        ftp://ftp.openwall.com/pub/projects/john/contrib/john-1.6.31-eggpatch-8.diff.gz
#


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ppc ~alpha ~amd64"
#KEYWORDS removed until "generic" target is fixed - "~mips ~hppa"
IUSE="mmx ntlm skey mysql kerberos"

RDEPEND="virtual/libc
	skey? ( app-admin/skey )
	kerberos? ( dev-libs/openssl )"

DEPEND="${RDEPEND}
	sys-devel/binutils
	sys-devel/gcc
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	epatch ${PF/theripper/}-gentoo.patch
}

src_compile() {
	cd src
	sed -i -e "s:^\(CFLAGS =.*\):\1 ${CFLAGS}:" \
		Makefile

	sed -i -e 's:^#define CFG_ALT_NAME.*:#define CFG_ALT_NAME "/etc/john.ini":' \
	-e 's:^#define WORDLIST_NAME.*:#define WORDLIST_NAME "/usr/share/john/password.lst":' \
	params.h

	local OPTIONS="EGG=true"
	use kerberos && OPTIONS="${OPTIONS} KERBEROS=true"
	use ntlm && OPTIONS="${OPTIONS} NTLM=true"
	use skey && OPTIONS="${OPTIONS} SKEY=true"
	use mysql && OPTIONS="${OPTIONS} MYSQL=true"

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
	else
		emake ${OPTIONS} generic || die "Make failed"
	fi

	#use debug && emake bench

}

src_install() {
	insinto /etc
	doins run/john.ini debian/john-mail.msg debian/john-mail.conf
	insinto /usr/share/${PN/theripper/}
	doins run/password.lst \
		debian/john-dailyscript
	doman debian/*.1
	dosbin run/john debian/mailer debian/john-cronjob

	dosym john /usr/sbin/unafs
	dosym john /usr/sbin/unique
	dosym john /usr/sbin/unshadow

	# for EGG only
	dosym john /usr/sbin/undrop

	# use debug && dobin src/bench

	dodoc debian/{CONFIG.mailer,copyright} doc/*
}
