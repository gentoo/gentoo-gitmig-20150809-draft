# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-notify/qmail-notify-0.93-r1.ebuild,v 1.2 2003/09/05 08:56:53 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Delayed delivery notification for qmail."
SRC_URI="http://untroubled.org/qmail-notify/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/qmail-notify/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND="virtual/glibc"

RDEPEND="virtual/cron
	net-mail/qmail"

src_compile() {
	cd ${S}
	echo "${CC} ${CFLAGS}" > conf-cc
	echo "${CC} ${LDFLAGS}" > conf-ld
	emake || die
}

src_install () {
	exeinto /usr/sbin
	doexe qmail-notify

	exeinto /etc/cron.hourly
	doexe ${FILESDIR}/qmail-notify.cron

	dodoc README ANNOUNCEMENT TODO cron.hourly NEWS VERSION
}

pkg_postinst() {
	echo
	einfo "Edit qmail-notify.cron in /etc/cron.hourly"
	einfo "to activate qmail-notify!"
	echo
}
