# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/qmail-notify/qmail-notify-0.93-r1.ebuild,v 1.8 2006/02/20 20:56:14 hansmi Exp $

inherit toolchain-funcs

DESCRIPTION="Delayed delivery notification for qmail."
SRC_URI="http://untroubled.org/qmail-notify/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/qmail-notify/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~hppa ~ppc sparc x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="
	${DEPEND}
	virtual/cron
	virtual/qmail
"

src_compile() {
	cd ${S}
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
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
