# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dcron/dcron-2.7-r10.ebuild,v 1.5 2003/12/27 05:14:55 seemant Exp $

# to use this, you must be part of the "cron" group

inherit eutils

S=${WORKDIR}/${PN}
DESCRIPTION="A cute little cron from Matt Dillon"
HOMEPAGE="http://apollo.backplane.com/"
SRC_URI="http://apollo.backplane.com/FreeSrc/dcron27.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc sparc hppa mips"

DEPEND="virtual/glibc
	>=sys-apps/sed-4"

RDEPEND="!virtual/cron
	sys-apps/cronbase
	virtual/mta"

PROVIDE="virtual/cron"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-Makefile-gentoo.diff

	# fix 'crontab -e' to look at $EDITOR and not $VISUAL
	sed -i 's:VISUAL:EDITOR:g' crontab.c

	sed -i 's:VISUAL:EDITOR:g' crontab.1

	# fix for lines starting with whitespace
	epatch ${FILESDIR}/${P}-whitespace.diff
}

src_compile() {
	make || die
}

src_install() {

	#this does not work if the directory already exists
	diropts -m 0750 -o root -g cron
	keepdir /var/spool/cron/crontabs


	exeopts -m 0700 -o root -g wheel
	exeinto /usr/sbin
	doexe crond

	exeopts -m 4750 -o root -g cron
	exeinto /usr/bin
	doexe crontab

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
