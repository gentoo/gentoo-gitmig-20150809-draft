# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/johntheripper/johntheripper-1.6.ebuild,v 1.25 2006/01/07 23:19:34 dragonheart Exp $

inherit eutils

MY_P=${P/theripper/}
S=${WORKDIR}/${MY_P}
DEBPATCH=${MY_P/-/_}-17.diff
DESCRIPTION="fast password cracker"
HOMEPAGE="http://www.openwall.com/${PN/theripper/}/"
SRC_URI="http://www.openwall.com/john/dl/${MY_P}.tar.gz
	 mirror://debian/pool/main/j/john/${DEBPATCH}.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc alpha ~mips hppa"
IUSE="mmx"

DEPEND=">=sys-devel/binutils-2.8.1.0.15
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${DEBPATCH}
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
	sed -i -e "s:-m486::" -e "s:-Wall -O2:${CFLAGS}:" \
		Makefile
	if use mmx ; then
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
