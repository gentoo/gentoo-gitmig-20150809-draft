# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>, Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dcron/dcron-2.7-r6.ebuild,v 1.3 2001/11/13 18:32:30 azarah Exp $

# to use this, you must be part of the "cron" group

S=${WORKDIR}/dcron
DESCRIPTION="A cute little cron from Matt Dillon"
SRC_URI="http://apollo.backplane.com/FreeSrc/dcron27.tgz"
HOMEPAGE="http://apollo.backplane.com"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-Makefile-gentoo.diff || die
}

src_compile() {
	make || die
}

src_install() {
	# lets just do it this way shall we
	dodir /usr/{sbin,bin}
	install -o root -g wheel -m 0700 crond ${D}/usr/sbin
	install -o root -g cron -m 4750 crontab ${D}/usr/bin

	diropts -m0755 ; dodir /var
	diropts -m0750 ; dodir /var/cron/lastrun
	# gotcha: /var/spool needs to be 755
	diropts -m0755 ; dodir /var/spool
	diropts -m0750 ; dodir /var/spool/cron/crontabs
	# this still do not alway get created
	touch ${D}/var/spool/cron/crontabs/.dummy

	dodoc CHANGELOG README
	doman crontab.1 crond.8

	insinto /etc ; doins ${FILESDIR}/crontab

	exeinto /etc/init.d ; newexe ${FILESDIR}/dcron.rc6 dcron
}
