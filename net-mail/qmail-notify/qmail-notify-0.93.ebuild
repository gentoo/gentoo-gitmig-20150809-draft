# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Maintainer: Thilo Bangert <bangert@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-notify/qmail-notify-0.93.ebuild,v 1.1 2002/06/17 14:58:22 bangert Exp $

S=${WORKDIR}/${P}

DEPEND="virtual/glibc"

RDEPEND="virtual/cron
	net-mail/qmail"

DESCRIPTION="Delayed delivery notification for qmail."
SRC_URI="http://untroubled.org/qmail-notify/${P}.tar.gz"

HOMEPAGE="http://untroubled.org/qmail-notify/"
LICENSE="GPL-2"

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
