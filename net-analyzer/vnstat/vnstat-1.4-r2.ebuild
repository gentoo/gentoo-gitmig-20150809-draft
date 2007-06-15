# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/vnstat/vnstat-1.4-r2.ebuild,v 1.9 2007/06/15 22:47:46 angelos Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Console-based network traffic monitor that keeps statistics of network usage"
HOMEPAGE="http://humdi.net/vnstat/"
SRC_URI="http://humdi.net/vnstat/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="virtual/cron"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}/${P}-long_iface_name.patch" \
		"${FILESDIR}/${P}-dbdir.patch"
	sed -i \
		-e "s:^\(CFLAGS = \).*$:\1${CFLAGS}:" \
		-e "s:^\(CC = \).*$:\1$(tc-getCC):" \
		src/Makefile || die "sed failed"
}

src_compile() {
	emake || die
}

src_install() {
	keepdir /var/lib/vnstat

	dobin src/vnstat || die
	exeinto /etc/cron.hourly
	newexe ${FILESDIR}/vnstat.cron vnstat
	doman man/vnstat.1

	newdoc pppd/vnstat_ip-down ip-down.example
	newdoc pppd/vnstat_ip-up ip-up.example
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
		elog "vnstat\'s cron script is now installed as /etc/cron.hourly/vnstat."
		elog "Please remove /etc/cron.d/vnstat."
		elog
	else
		elog "A cron script has been installed to /etc/cron.hourly/vnstat."
		elog
	fi
	elog "To update your interface database automatically with"
	elog "cron, uncomment the lines in /etc/cron.hourly/vnstat."
}
