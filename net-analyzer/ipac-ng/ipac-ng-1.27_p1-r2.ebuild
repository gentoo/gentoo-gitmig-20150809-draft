# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ipac-ng/ipac-ng-1.27_p1-r2.ebuild,v 1.1 2004/02/28 06:55:00 mboman Exp $

DESCRIPTION="ip accounting suite for 2.4 and 2.6 series kernels with text and PNG image output like mrtg"
HOMEPAGE="http://sourceforge.net/projects/ipac-ng/"
SRC_URI="mirror://sourceforge/ipac-ng/${P/_p/pl}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gd"

DEPEND="sys-devel/bison
	sys-devel/flex
	dev-lang/perl
	sys-libs/gdbm
	gd? ( dev-perl/GD )
	sys-devel/flex
	virtual/glibc"
RDEPEND="net-firewall/iptables
	virtual/cron
	dev-lang/perl
	sys-libs/gdbm
	gd? ( dev-perl/GD )
	virtual/glibc"

S=${WORKDIR}/${P/_p*}

src_compile() {
	econf \
		--enable-default-storage=gdbm \
		--enable-default-agent=iptables \
		--enable-default-access=files \
		--enable-classic=yes \
		|| die "./configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodir /var/lib/ipac

	insinto /etc/ipac-ng
	newins ${FILESDIR}/ipac.conf.${PVR} ipac.conf
	newins ${FILESDIR}/rules.conf.${PVR} rules.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/ipac-ng.rc.${PVR} ipac-ng

	exeinto /etc/cron.hourly
	newexe ${FILESDIR}/ipac-ng.cron.${PVR} ipac-ng

	dodoc  COPYING README* TODO UPDATE* CHANGES
}

pkg_postinst() {
	einfo "W A R N I N G !"
	einfo "do not use \"/etc/init.d/iptables save\" when ipac-ng is running!"
	einfo "this WILL save ipac rules and can cause problems!"
	einfo "ipac-ng should be started AFTER iptables and shut down BEFORE iptables"
	einfo "use /etc/init.d/iptables save only when ipac rules are removed!"
	einfo "the accounting database is at /var/lib/ipac"
	einfo "use /usr/sbin/ipacsum to get your ip acounting data"
	einfo "use /usr/sbin/fetchipac to update the accounting at any time"
	einfo "fetchipac is run by cron every hour by /etc/cron.daily/ipac-ng"
	einfo "after you changed rules.conf you have to run \"fetchipac -S\" or"
	einfo "stop/start the service so your iptables gets updated"
	einfo "if ipac is not working with the default configuration make"
	einfo "rm /etc/ipac-ng/* and rm /var/lib/ipac/* and emerge again"
}
