# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/johntheripper/johntheripper-1.6.ebuild,v 1.9 2003/02/13 05:38:41 seemant Exp $

inherit eutils

IUSE="mmx"

MY_PN=${PN/theripper/}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DEBPATCH=${MY_PN}_${PV}-17.diff
DESCRIPTION="John the Ripper is a fast password cracker."
HOMEPAGE="http://www.openwall.com/${PN0}/"
SRC_URI="${HOMEPAGE}/${MY_P}.tar.gz
	 http://ftp.debian.org/debian/pool/main/j/${PN0}/${DEBPATCH}.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc ~alpha ~mips ~hppa"

DEPEND=">=sys-devel/binutils-2.8.1.0.15"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${DEBPATCH}
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
	dodir /usr/share/${PN0} /etc
	insinto /etc
	doins run/john.ini debian/john-mail.msg debian/john-mail.conf
	insinto /usr/share/${PN0}
	doins run/{all.chr,alpha.chr,digits.chr,lanman.chr,password.lst} \
		debian/john-dailyscript
	dodoc debian/{CONFIG.mailer,copyright} doc/* 
	doman debian/{john.1,mailer.1,unafs.1,unique.1,unshadow.1,john-cronjob.1}
	dosbin run/john debian/mailer debian/john-cronjob
	(cd ${D}/usr/sbin; ln -s john unafs; ln -s john unique; ln -s john unshadow)
}
