# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ipac-ng/ipac-ng-1.31-r2.ebuild,v 1.10 2009/01/15 05:25:43 jer Exp $

inherit eutils

DESCRIPTION="ip accounting suite for 2.4 and 2.6 series kernels with text and PNG image output like mrtg"
HOMEPAGE="http://sourceforge.net/projects/ipac-ng/"
SRC_URI="mirror://sourceforge/ipac-ng/${P}.tar.bz2
	mirror://gentoo/${P}-patches.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="gd sqlite postgres"

RDEPEND="postgres? ( virtual/postgresql-server )
		!postgres? ( sqlite? ( =dev-db/sqlite-2* )
					!sqlite? ( sys-libs/gdbm ) )"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"
RDEPEND="${RDEPEND}
	net-firewall/iptables
	virtual/cron
	dev-lang/perl
	gd? ( dev-perl/GD )
	virtual/logger"

pkg_setup() {
	if use sqlite && use postgres ; then
		die "You have both sqlite and postgres in USE. Please choose one or the other."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${WORKDIR}"/${P}-iptables-1.3.1.patch
	epatch "${WORKDIR}"/ipcop-${P}-fetchcounter.patch
	epatch "${FILESDIR}"/${P}-lable-at-the-end-of-compound.patch
	epatch "${FILESDIR}"/${P}-strip.patch
}

src_compile() {
	local db="gdbm"
	use sqlite && db="sqlite"
	use postgres && db="postgres"

	econf \
		--enable-default-storage=${db} \
		--enable-default-agent=iptables \
		--enable-default-access=files \
		--enable-classic=yes \
		|| die "configure failed"

	emake -j1 || die "make failed"
}

src_test() {
	einfo "self test is broken"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodir /var/lib/ipac

	insinto /etc/ipac-ng
	newins "${FILESDIR}"/ipac.conf.1.30 ipac.conf
	newins "${FILESDIR}"/rules.conf.1.30 rules.conf

	newinitd "${FILESDIR}"/ipac-ng.rc.1.30 ipac-ng

	exeinto /etc/cron.hourly
	newexe "${FILESDIR}"/ipac-ng.cron.1.30 ipac-ng

	dodoc README TODO doc/* CHANGELOG
}

pkg_postinst() {
	ewarn
	ewarn "                         W A R N I N G !"
	ewarn "do not use \"/etc/init.d/iptables save\" when ipac-ng is running!"
	ewarn "this WILL save ipac rules and can cause problems!"
	ewarn "ipac-ng should be started AFTER iptables and shut down BEFORE iptables"
	ewarn "use /etc/init.d/iptables save only when ipac rules are removed!"
	ewarn
	einfo "the accounting database is at /var/lib/ipac"
	einfo "use /usr/sbin/ipacsum to get your ip acounting data"
	einfo "use /usr/sbin/fetchipac to update the accounting at any time"
	einfo "fetchipac is run by cron every hour by /etc/cron.hourly/ipac-ng"
	einfo "after you changed rules.conf you have to run \"fetchipac -S\" or"
	einfo "stop/start the service so your iptables gets updated"
	einfo "if ipac is not working with the default configuration make"
	einfo "rm /etc/ipac-ng/* and rm /var/lib/ipac/* and emerge again"
}
