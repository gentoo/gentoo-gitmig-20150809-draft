# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Maintainer: Thilo Bangert <bangert@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-notify/qmail-notify-0.92.ebuild,v 1.3 2002/04/27 21:46:44 bangert Exp $

S=${WORKDIR}/${P}

DEPEND="virtual/glibc"

RDEPEND="virtual/cron
	net-mail/qmail"

DESCRIPTION="Delayed delivery notification for qmail."
SRC_URI="http://untroubled.org/qmail-notify/${P}.tar.gz"

HOMEPAGE="http://untroubled.org/qmail-notify/"

src_compile() {
	cd ${S}
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	emake || die
}

src_install () {
	exeinto /usr/sbin
	doexe qmail-notify

	exeinto /etc/cron.hourly
	doexe ${FILESDIR}/qmail-notify.cron

	dodoc README ANNOUNCEMENT TODO cron.hourly
}


pkg_postinst() {

    echo
    einfo "Edit qmail-notify.cron in /etc/cron.hourly"
    einfo "to activate qmail-notify!"
    echo


}
