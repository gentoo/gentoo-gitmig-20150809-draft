# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/vnstat/vnstat-1.7.ebuild,v 1.1 2009/04/18 15:30:14 patrick Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Console-based network traffic monitor that keeps statistics of network usage"
HOMEPAGE="http://humdi.net/vnstat/"
SRC_URI="http://humdi.net/vnstat/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="virtual/cron"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "Compilation failed"
}

src_install() {
	dobin src/vnstat || die
	exeinto /etc/cron.hourly
	newexe "${FILESDIR}"/vnstat.cron vnstat

	insinto /etc
	doins cfg/vnstat.conf

	doman man/vnstat.1

	keepdir /var/lib/vnstat

	newdoc pppd/vnstat_ip-up ip-up.example
	newdoc pppd/vnstat_ip-down ip-down.example
	dodoc CHANGES README UPGRADE FAQ
	newdoc INSTALL README.setup
}

pkg_postinst() {
	# compatibility for 1.1 ebuild
	if [[ -d ${ROOT}/var/spool/vnstat ]] ; then
		mv -f "${ROOT}"/var/spool/vnstat/* "${ROOT}"/var/lib/vnstat/ \
			&& rmdir "${ROOT}"/var/spool/vnstat
		elog "vnStat db files moved from /var/spool/vnstat to /var/lib/vnstat"
		elog
	fi

	elog "Repeat the following command for every interface you"
	elog "wish to monitor (replace eth0):"
	elog "   vnstat -u -i eth0"
	elog
	elog "Note: if an interface transfers more than ~4GB in"
	elog "the time between cron runs, you may miss traffic"
	elog

	if [[ -e ${ROOT}/etc/cron.d/vnstat ]] ; then
		elog "vnstat's cron script is now installed as /etc/cron.hourly/vnstat."
		elog "Please remove /etc/cron.d/vnstat."
		elog
	else
		elog "A cron script has been installed to /etc/cron.hourly/vnstat."
		elog
	fi
	elog "To update your interface database automatically with"
	elog "cron, uncomment the lines in /etc/cron.hourly/vnstat."
	elog
	elog "Starting with version 1.5 --dbdir option is droped. You can do the same"
	elog "with DatabaseDir directive in configuration file (/etc/vnstat.conf)."
}
