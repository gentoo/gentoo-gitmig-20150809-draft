# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dcron/dcron-2.7-r8.ebuild,v 1.3 2002/07/14 19:20:16 aliz Exp $

# to use this, you must be part of the "cron" group

S=${WORKDIR}/dcron
DESCRIPTION="A cute little cron from Matt Dillon"
SRC_URI="http://apollo.backplane.com/FreeSrc/dcron27.tgz"
HOMEPAGE="http://apollo.backplane.com"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-Makefile-gentoo.diff || die
	# fix 'crontab -e' to look at $EDITOR and not $VISUAL
	cp ${S}/crontab.c ${S}/crontab.c.orig
	sed -e 's:VISUAL:EDITOR:g' ${S}/crontab.c.orig > ${S}/crontab.c
	cp ${S}/crontab.1 ${S}/crontab.1.orig
	sed -e 's:VISUAL:EDITOR:g' ${S}/crontab.1.orig > ${S}/crontab.1
	# fix for lines starting with whitespace
	patch -p0 < ${FILESDIR}/${P}-whitespace.diff || die
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
