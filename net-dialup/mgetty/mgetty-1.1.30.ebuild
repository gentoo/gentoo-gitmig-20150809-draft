# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/mgetty/mgetty-1.1.30.ebuild,v 1.1 2003/04/28 09:29:35 aliz Exp $

inherit flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="Fax and Voice modem programs."
SRC_URI="ftp://alpha.greenie.net/pub/mgetty/source/1.1/${PN}${PV}-Dec16.tar.gz"
HOMEPAGE="http://alpha.greenie.net/mgetty/"

DEPEND=">=sys-apps/portage-2.0.47-r10
	>=sys-apps/sed-4.0.5
	app-text/tetex
	sys-apps/gawk
	dev-lang/perl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/mgetty-${PV}-gentoo.diff
	
	cd ${S}/doc
	sed -i "s:dvips -o mgetty.ps:dvips -M -o mgetty.ps:" Makefile

	cd ${S}
	sed -e 's:var/log/mgetty:var/log/mgetty/mgetty:' \
		-e 's:var/log/sendfax:var/log/mgetty/sendfax:' \
		-e 's:\/\* \(\#define CNDFILE "dialin.config"\) \*\/:\1:' \
		-e 's:\(\#define FAX_NOTIFY_PROGRAM\).*:\1 "/etc/mgetty+sendfax/new_fax":' \
		policy.h-dist > policy.h
}

src_compile() {
	append-flags "-DAUTO_PPP"

	emake prefix=/usr \
		CONFDIR=/etc/mgetty+sendfax \
		CFLAGS="${CFLAGS}" \
		|| make prefix=/usr \
			CONFDIR=/etc/mgetty+sendfax \
			CFLAGS="${CFLAGS}" \
			|| die

	cd voice
	emake CONFDIR=/etc/mgetty+sendfax \
		|| make CONFDIR=/etc/mgetty+sendfax \
			|| die
	cd ${S}
}

src_install () {
	dodir /var/spool
	dodir /usr/share/info
	make prefix=${D}/usr \
		INFODIR=${D}/usr/share/info \
		CONFDIR=${D}/etc/mgetty+sendfax \
		MAN1DIR=${D}/usr/share/man/man1 \
		MAN4DIR=${D}/usr/share/man/man4 \
		MAN5DIR=${D}/usr/share/man/man5 \
		MAN8DIR=${D}/usr/share/man/man8 \
		spool=${D}/var/spool \
		install || die

	cd voice
	make prefix=${D}/usr \
		CONFDIR=${D}/etc/mgetty+sendfax \
		MAN1DIR=${D}/usr/share/man/man1 \
		MAN8DIR=${D}/usr/share/man/man8 \
		VOICE_DIR=${D}/var/spool/voice \
		PHONE_GROUP=root \
		PHONE_PERMS=755 \
		install || die

	cd ${S}
	dodoc BUGS ChangeLog FTP README.1st Recommend THANKS TODO
	cd doc
	dodoc *.txt modems.db mgetty.ps

	#generate missing fonts if any.
	if [ -f ${S}/doc/missfont.log ]
	then
		echo '#!/bin/bash' >genfonts.sh
		cat missfont.log >>genfonts.sh
		chmod +x genfonts.sh
		dodoc genfonts.sh
	fi
}

pkg_postinst() {
	#generate missing fonts if any.
	if [ -x {$ROOT}/usr/share/doc/${PF}/genfonts.sh ]
	then
		{$ROOT}/usr/share/doc/${PF}/genfonts.sh
	fi

	if [ ! -d ${ROOT}/var/spool/fax/incoming ]
	then
		mkdir -p ${ROOT}/var/spool/fax/incoming
	fi
	if [ ! -d ${ROOT}/var/spool/fax/outgoing/locks ]
	then
		mkdir -p ${ROOT}/var/spool/fax/outgoing/locks
	fi
}

