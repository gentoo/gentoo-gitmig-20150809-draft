# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/johntheripper/johntheripper-1.6-r2.ebuild,v 1.1 2004/05/18 04:09:39 dragonheart Exp $

inherit eutils

MY_P=${P/theripper/}
S=${WORKDIR}/${MY_P}
DEBPATCH=${MY_P/-/_}-17.diff
DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/${PN/theripper/}/"
SRC_URI="http://www.openwall.com/john/dl/${MY_P}.tar.gz
	mirror://debian/pool/main/j/${PN/theripper/}/${DEBPATCH}.gz
	ntlm? ( ftp://ftp.openwall.com/pub/projects/john/contrib/john-ntlm-patch-v02.tgz )
	kerberos? ( http://www.monkey.org/~dugsong/john-1.6.krb4.patch-3 )
	skey? ( http://www.monkey.org/~dugsong/john-1.6.skey.patch-1 )"

#	mysql? ( ftp://ftp.openwall.com/pub/projects/john/contrib/john-1.6-mysql-1.diff )
#	ftp://ftp.openwall.com/pub/projects/john/contrib/john-1.6.31-eggpatch-8.diff.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~mips ~hppa"
IUSE="mmx ntlm skey mysql"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	>=sys-devel/binutils-2.8.1.0.15
	skey? ( app-admin/skey )"


src_unpack() {
	unpack ${A}
	if use ntlm
	then
		if use skey
		then
				cd ${WORKDIR}/john-ntlm-patch-v02/
				epatch ${FILESDIR}/john-ntlm.skey.patch
		fi
	fi
	cd ${S}
	epatch ${WORKDIR}/${DEBPATCH}
	cd ${S}/src
	if use skey
	then
		epatch ${DISTDIR}/${MY_P}.skey.patch-1
	fi
	cd ${S}

#	use mysql && epatch ${DISTDIR}/${MY_P}-mysql-1.diff
#	epatch ${WORKDIR}/${MY_P}.31-eggpatch-8.diff

	if use ntlm
	then
		mv ${WORKDIR}/john-ntlm-patch-v02/* ${S}/src
		cd ${S}/src
		epatch john-ntlm.diff
		cd ${S}
	fi

	if use kerberos
	then
		epatch ${DISTDIR}/${MY_P}.krb4.patch-3
	fi
}

src_compile() {
	cd src
	sed -i -e "s:-m486::" -e "s:-Wall -O2:${CFLAGS}:" \
		Makefile
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
