# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/johntheripper/johntheripper-1.6-r1.ebuild,v 1.4 2003/09/05 01:33:49 msterret Exp $

inherit eutils

MY_P=${P/theripper/}
S=${WORKDIR}/${MY_P}
DEBPATCH=${MY_P/-/_}-17.diff
DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/${PN/theripper/}/"
SRC_URI="${HOMEPAGE}/${MY_P}.tar.gz
	http://ftp.debian.org/debian/pool/main/j/${PN/theripper/}/${DEBPATCH}.gz
	mysql? ( http://www.openwall.com/john/contrib/john-1.6-mysql-1.diff )
	samba? ( http://www.openwall.com/john/contrib/john-ntlm-patch-v02.tgz )
	kerberos? ( http://www.monkey.org/~dugsong/john-1.6.krb4.patch-3 )
	http://www.monkey.org/~dugsong/john-1.6.skey.patch-1
	http://www.openwall.com/john/contrib/john-1.6.31-eggpatch-8.diff.gz"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-x86 -sparc -ppc -alpha -mips -hppa"
IUSE="mmx samba"

DEPEND=">=sys-devel/binutils-2.8.1.0.15"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${DEBPATCH}
	cd ${S}/src
	epatch ${DISTDIR}/${MY_P}.skey.patch-1
	cd ${S}
#	use mysql && epatch ${DISTDIR}/${MY_P}-mysql-1.diff

	if use samba
	then
		mv ${WORKDIR}/john-ntlm-patch-v02/* ${S}/src
		cd ${S}/src
		epatch john-ntlm.diff
		cd ${S}
	fi

	epatch ${WORKDIR}/${MY_P}.31-eggpatch-8.diff
	if use kerberos
	then
		patch -p0 < ${DISTDIR}/${MY_P}.krb4.patch-3 || die
	fi
}

src_compile() {
	cd src
	mv Makefile Makefile.orig
	sed -e "s:-m486::" -e "s:-Wall -O2:${CFLAGS}:" \
		Makefile.orig > Makefile
	if [ `use mmx` ] ; then
		emake linux-x86-mmx-elf || die
	else
		emake generic || die
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

	dodoc debian/{CONFIG.mailer,copyright} doc/*
}
