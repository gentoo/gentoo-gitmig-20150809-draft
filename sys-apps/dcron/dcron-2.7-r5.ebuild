# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dcron/dcron-2.7-r5.ebuild,v 1.1 2001/08/19 21:05:27 drobbins Exp $

S=${WORKDIR}/dcron
DESCRIPTION="A cute little cron from Matt Dillon."
SRC_URI="http://apollo.backplane.com/FreeSrc/dcron27.tgz"

HOMEPAGE="http://apollo.backplane.com"

DEPEND="virtual/glibc"
#debianutils is needed for start-stop-daemon (init.d script)
RDEPEND="$DEPEND sys-apps/debianutils"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-Makefile-gentoo.diff
}

src_compile() {
	try make
}

src_install() {
    try make DESTDIR=${D} install
	
	#important fix!
	dodir /usr/sbin
	mv ${D}/usr/bin/crond ${D}/usr/sbin
	#to use cron, you must be part of the "cron" group

	diropts -m0750
	dodir /var/spool/cron/crontabs /var/cron/lastrun
	dodoc CHANGELOG README
	insinto /etc
	doins ${FILESDIR}/crontab
	exeinto /etc/init.d
	newexe ${FILESDIR}/dcron-newinit dcron
}

