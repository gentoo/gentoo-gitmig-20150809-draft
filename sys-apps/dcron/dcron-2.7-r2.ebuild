# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dcron/dcron-2.7-r2.ebuild,v 1.1 2001/01/15 07:15:39 jerry Exp $

A=dcron27.tgz
S=${WORKDIR}/dcron
DESCRIPTION="A cute little cron from Matt Dillon (kung-fu master)"
SRC_URI="http://apollo.backplane.com/FreeSrc/${A}"

HOMEPAGE="http://apollo.backplane.com"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
	try make
}

src_install() {
	#to use cron, you must be part of the "cron" group
	dobin crontab
	dosbin crond
	chown root.wheel ${D}/usr/sbin/crond
	chown root.cron ${D}/usr/bin/crontab
	chmod 700 ${D}/usr/sbin/crond
	chmod 4755 ${D}/usr/bin/crontab
	doman *.[18]
	diropts -m0750
	dodir /var/spool/cron/crontabs /var/cron/lastrun
	dodoc CHANGELOG README

	#set up supervise support
	exeinto /var/lib/supervise/services/dcron 
	newexe ${FILESDIR}/dcron-run run
	#this next line tells svcan to start the log process too (and set up a pipe)
	chmod +t ${D}/var/lib/supervise/services/dcron
	exeinto /var/lib/supervise/services/dcron/log
	newexe ${FILESDIR}/log-run run

	#install rc script
	exeinto /etc/rc.d/init.d
	doexe ${FILESDIR}/dcron ${FILESDIR}/svc-dcron

	insinto /etc
	doins ${FILESDIR}/crontab
}

