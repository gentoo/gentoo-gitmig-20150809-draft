# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/vixie-cron/vixie-cron-3.0.1-r1.ebuild,v 1.10 2005/01/10 06:49:11 ciaranm Exp $

inherit eutils

IUSE=""

DESCRIPTION="The Vixie cron daemon"
HOMEPAGE="http://www.vix.com/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/${P}-gentoo.patch.bz2"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 amd64 ppc sparc alpha mips hppa ia64"

DEPEND=">=sys-apps/portage-2.0.47-r10
	>=sys-apps/sed-4.0.5"

RDEPEND="!virtual/cron
	 sys-apps/cronbase
	 virtual/mta"

PROVIDE="virtual/cron"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${WORKDIR}/${P}-gentoo.patch

	sed -i "s:-O2:${CFLAGS}:" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	#this does not work if the directory exists already
	diropts -m0750 -o root -g cron
	keepdir /var/spool/cron/crontabs/

	doman crontab.1 crontab.5 cron.8

	dodoc CHANGES CONVERSION FEATURES MAIL MANIFEST README THANKS

	diropts -m0755 ; dodir /etc/cron.d
	keepdir /etc/cron.d

	exeinto /etc/init.d
	newexe ${FILESDIR}/vixie-cron.rc6 vixie-cron

	insinto /etc
	doins ${FILESDIR}/crontab

	dodoc ${FILESDIR}/crontab

	insinto /usr/sbin
	insopts -o root -g root -m 0750 ; doins cron

	insinto /usr/bin
	insopts -o root -g cron -m 4750 ; doins crontab
}

pkg_postinst() {

	if [ -f ${ROOT}/etc/init.d/vcron ]
	then
		ewarn "Please run:"
		ewarn "rc-update del vcron"
		ewarn "rc-update add vixie-cron default"
	fi

	echo
	einfo "You may wish to read the Gentoo Linux Cron Guide, which can be"
	einfo "found online at:"
	einfo "    http://www.gentoo.org/doc/en/cron-guide.xml"
	echo
}
