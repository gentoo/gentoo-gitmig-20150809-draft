# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Updated by Todd Wright <wylie@geekasylum.org> -r3
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp

S=${WORKDIR}/${P}
DESCRIPTION="Fax and Voice modem programs."

SRC_URI="ftp://alpha.greenie.net/pub/mgetty/source/1.1/${PN}${PV}-Apr16.tar.gz"
HOMEPAGE="http://alpha.greenie.net/mgetty"

DEPEND="sys-libs/glibc
	app-text/tetex
	sys-apps/gawk
	sys-devel/perl"

src_unpack() {
	unpack ${A}

	cd ${S}/doc
	patch -p0 < ${FILESDIR}/mgetty-${PV}-gentoo.diff || die
	
	cp Makefile Makefile.orig
	sed -e "s:dvips -o mgetty.ps:dvips -M -o mgetty.ps:" \
		Makefile.orig >Makefile

	cd ${S}
	sed -e 's:var/log/mgetty:var/log/mgetty/mgetty:' \
		-e 's:var/log/sendfax:var/log/mgetty/sendfax:' \
		-e 's:\/\* \#define CNDFILE "dialin.config" \*\/:\#define CNDFILE "dialin.config":' \
		policy.h-dist > policy.h
}

src_compile() {
	mycflags="${CFLAGS}"
	unset CFLAGS
	emake prefix=/usr \
		CONFDIR=/etc/mgetty+sendfax \
		CFLAGS="${mycflags}" \
		|| die
	cd voice
	emake CONFDIR=/etc/mgetty+sendfax \
		CFLAGS="${mycflags}" \
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

