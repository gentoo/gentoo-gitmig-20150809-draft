# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openntpd/openntpd-20040719p.ebuild,v 1.3 2004/08/21 04:03:18 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Lightweight NTP server ported from OpenBSD"
HOMEPAGE="http://www.openntpd.org/"
SRC_URI="http://www.openntpd.org/dist/portable/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/libc
	!net-misc/ntp"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i '/NTPD_USER/s:_ntp:ntp:' ntpd.h || die
}

pkg_preinst() {
	enewgroup ntp 123
	enewuser ntp 123 /bin/false /var/empty ntp
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc ChangeLog CREDITS README

	exeinto /etc/init.d
	newexe ${FILESDIR}/openntpd.rc ntpd
	insinto /etc/conf.d
	newins ${FILESDIR}/openntpd.conf.d ntpd
}
