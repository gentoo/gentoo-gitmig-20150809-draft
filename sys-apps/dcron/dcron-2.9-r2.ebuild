# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dcron/dcron-2.9-r2.ebuild,v 1.3 2004/04/07 21:11:53 avenj Exp $

# to use this, you must be part of the "cron" group

inherit eutils

MY_PV=29
S=${WORKDIR}/${PN}
DESCRIPTION="A cute little cron from Matt Dillon"
SRC_URI="http://apollo.backplane.com/FreeSrc/${PN}${MY_PV}.tgz"
HOMEPAGE="http://apollo.backplane.com/"
KEYWORDS="~x86 amd64 ~ppc ~sparc ~hppa alpha ~mips"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=sys-apps/sed-4"

RDEPEND="!virtual/cron
	>=sys-apps/cronbase-0.2.1-r3
	virtual/mta"

PROVIDE="virtual/cron"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/dcron-2.7-Makefile-gentoo.diff

	# fix 'crontab -e' to look at $EDITOR and not $VISUAL
	sed -i 's:VISUAL:EDITOR:g' ${S}/crontab.c

	sed -i 's:VISUAL:EDITOR:g' ${S}/crontab.1

	# remove gcc hardcode
	sed -i "s:\(CC  = \)gcc:\1${CC:-gcc}:" ${S}/Makefile
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
	# reset execopts after setuid install of crontab to
	# prevent init.d/dcron from being installed setuid as well
	exeopts -m 0750 -o root -g root

	dodoc CHANGELOG README ${FILESDIR}/crontab
	doman crontab.1 crond.8

	exeinto /etc/init.d ; newexe ${FILESDIR}/dcron.rc6 dcron

	insopts -o root -g root -m 0644
	insinto /etc
	newins ${FILESDIR}/crontab-2.9-r1 crontab
}


pkg_postinst() {
	echo
	einfo "To activate /etc/cron.{hourly|daily|weekly|montly} please run: "
	einfo "crontab /etc/crontab"
	echo
	einfo "!!! That will replace root's current crontab !!!"
	echo
}
