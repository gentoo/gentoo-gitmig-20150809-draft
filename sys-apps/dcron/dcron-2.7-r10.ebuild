# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dcron/dcron-2.7-r10.ebuild,v 1.3 2003/04/18 20:28:56 tuxus Exp $

# to use this, you must be part of the "cron" group

S=${WORKDIR}/dcron
DESCRIPTION="A cute little cron from Matt Dillon"
SRC_URI="http://apollo.backplane.com/FreeSrc/dcron27.tgz"
HOMEPAGE="http://apollo.backplane.com/"
KEYWORDS="x86 ppc sparc hppa mips"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

RDEPEND="!virtual/cron
	sys-apps/cronbase
	virtual/mta"

PROVIDE="virtual/cron"

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

	#this does not work if the directory already exists
	diropts -m 0750 -o root -g cron
	dodir /var/spool/cron/crontabs
	keepdir /var/spool/cron/crontabs


	dodir /usr/{sbin,bin}
	install -o root -g wheel -m 0700 crond ${D}/usr/sbin
	install -o root -g cron -m 4750 crontab ${D}/usr/bin

	dodoc CHANGELOG README
	doman crontab.1 crond.8

	exeinto /etc/init.d ; newexe ${FILESDIR}/dcron.rc6 dcron

	insinto /etc
	doins ${FILESDIR}/crontab

	dodoc ${FILESDIR}/crontab
}


pkg_postinst() {

	echo
	einfo "To activate /etc/cron.{hourly|daily|weekly|montly} please run: "
	einfo "crontab /etc/crontab"
	echo
	einfo "!!! That will replace root's current crontab !!!"
	echo

}
