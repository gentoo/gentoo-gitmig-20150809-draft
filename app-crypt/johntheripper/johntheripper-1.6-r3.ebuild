# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/johntheripper/johntheripper-1.6-r3.ebuild,v 1.11 2006/01/07 11:24:14 dragonheart Exp $

inherit eutils flag-o-matic

MY_P="${P/theripper/}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/john/"
SRC_URI="http://www.openwall.com/john/dl/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}-gentoo.patch"

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
KEYWORDS="alpha ~hppa ~mips ~ppc ppc64 ~sparc ~x86"
IUSE="kerberos mmx mysql ntlm skey"

RDEPEND="virtual/libc
	skey? ( app-admin/skey )
	kerberos? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	sys-devel/binutils
	sys-devel/gcc
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	epatch "${DISTDIR}/${MY_P}-gentoo.patch"
	cd ${S}/src
	for file in  alpha.S  sparc.S  x86.S; do
		cat <<EOF >> ${file}
#ifdef __ELF__
.section .note.GNU-stack,"",@progbits
#endif
EOF

	done
}

src_compile() {
	cd src
	sed -i -e "s:-march=i486::" -e "s:-O2:${CFLAGS}:" \
		Makefile
	local OPTIONS="OPT_NORMAL= OPT_INLINE=  EGG=true"
	#local OPTIONS="EGG=true"
	use kerberos && OPTIONS="${OPTIONS} KERBEROS=true"
	use ntlm && OPTIONS="${OPTIONS} NTLM=true"
	use skey && OPTIONS="${OPTIONS} SKEY=true"
	if use mysql;
	then
		OPTIONS="${OPTIONS} MYSQL=true"
		# bug #106652 thanks to Rutger
		append-ldflags -lm
	fi

	if use x86 ; then
		if use mmx ; then
			emake ${OPTIONS} linux-x86-mmx-elf || die "Make failed"
		elif is-flag "-march=k6-3" || is-flag "-march=k6-2" \
				|| is-flag "-march=k6"; then
			emake ${OPTIONS} linux-x86-k6-elf || die "Make failed"
		else
			emake ${OPTIONS} generic || die "Make failed"
		fi
	elif use alpha ; then
		emake ${OPTIONS} linux-alpha || die "Make failed"
	elif use sparc; then
		emake ${OPTIONS} linux-sparc  || die "Make failed"
	else
		emake ${OPTIONS} generic || die "Make failed"
	fi

}
src_test() {
	cd run
	if  [[ -f /etc/john.ini  ]]
	then
		./john --test || die 'self test failed'
	else
		ewarn "selftest requires /etc/john.ini"
	fi
}

src_install() {
	insinto /etc
	doins run/john.ini debian/john-mail.msg debian/john-mail.conf
	insinto /usr/share/${PN/theripper/}
	doins run/{all.chr,alpha.chr,digits.chr,lanman.chr,password.lst} \
		debian/john-dailyscript
	doman debian/*.1
	dosbin run/john debian/mailer debian/john-cronjob

	dosym john /usr/sbin/unafs
	dosym john /usr/sbin/unique
	dosym john /usr/sbin/unshadow

	# for EGG only
	dosym john /usr/sbin/undrop

	dodoc debian/{CONFIG.mailer,copyright} doc/*
}
