# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# Maintainer: Thilo Bangert <bangert@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.3 2002/02/04 15:46:51 gbevin Exp

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
	exeinto /usr/bin
	doexe qmail-notify

	exeinto /etc/cron.hourly
	newexe cron.hourly qmail-notify.cron

	dodoc README ANNOUNCEMENT TODO cron.hourly
}


pkg_postinst() {

    echo
    einfo "A qmail-notify.cron was put in /etc/cron.hourly!"
    echo


}
