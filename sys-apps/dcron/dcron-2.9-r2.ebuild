# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dcron/dcron-2.9-r2.ebuild,v 1.18 2004/10/28 15:47:44 vapier Exp $

inherit eutils toolchain-funcs

MY_PV=29
DESCRIPTION="A cute little cron from Matt Dillon"
HOMEPAGE="http://apollo.backplane.com/"
SRC_URI="http://apollo.backplane.com/FreeSrc/${PN}${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND="virtual/libc
	>=sys-apps/sed-4"
RDEPEND="!virtual/cron
	>=sys-apps/cronbase-0.2.1-r3
	virtual/mta"
PROVIDE="virtual/cron"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/dcron-2.7-Makefile-gentoo.diff
	epatch ${FILESDIR}/dcron-2.9-ldflags.patch

	# fix 'crontab -e' to look at $EDITOR and not $VISUAL
	sed -i 's:VISUAL:EDITOR:g' crontab.{c,1}

	# remove gcc hardcode
	sed -i "s:\(CC  = \)gcc:\1$(tc-getCC):" Makefile
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
	doexe crond || die

	exeopts -m 4750 -o root -g cron
	exeinto /usr/bin
	doexe crontab || die
	# reset execopts after setuid install of crontab to
	# prevent init.d/dcron from being installed setuid as well
	exeopts -m 0750 -o root -g root

	dodoc CHANGELOG README ${FILESDIR}/crontab
	doman crontab.1 crond.8

	exeinto /etc/init.d ; doexe ${FILESDIR}/dcron

	insopts -o root -g root -m 0644
	insinto /etc
	doins ${FILESDIR}/crontab
}

pkg_postinst() {
	echo
	einfo "To activate /etc/cron.{hourly|daily|weekly|montly} please run: "
	einfo "crontab /etc/crontab"
	echo
	einfo "!!! That will replace root's current crontab !!!"
	echo
}
