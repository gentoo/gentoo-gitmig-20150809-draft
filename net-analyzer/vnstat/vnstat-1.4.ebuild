# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/vnstat/vnstat-1.4.ebuild,v 1.7 2004/07/29 05:03:49 vapier Exp $

DESCRIPTION="Console-based network traffic monitor that keeps statistics of network usage"
HOMEPAGE="http://humdi.net/vnstat/"
SRC_URI="http://humdi.net/vnstat/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

RDEPEND="virtual/cron"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	keepdir /var/lib/vnstat

	dobin src/vnstat || die
	exeinto /etc/cron.d
	newexe ${FILESDIR}/vnstat.cron vnstat
	doman man/vnstat.1

	newdoc pppd/vnstat_ip-down ip-down.example
	newdoc pppd/vnstat_ip-up ip-up.example
	dodoc CHANGES INSTALL README UPGRADE FAQ
}

pkg_postinst() {
	# compatibility for 1.1 ebuild
	if [ -d ${ROOT}/var/spool/vnstat ] ; then
		mv -f ${ROOT}/var/spool/vnstat/* ${ROOT}/var/lib/vnstat \
			&& rmdir ${ROOT}/var/spool/vnstat
		einfo "vnStat db files moved from /var/spool/vnstat to /var/lib/vnstat"
	fi

	einfo "Repeat the following command for every interface you"
	einfo "wish to monitor (replace eth0):"
	einfo "   vnstat -u -i eth0"

	einfo "Note: if an interface transfers more than ~4GB in"
	einfo "the time between cron runs, you may miss traffic"
}
