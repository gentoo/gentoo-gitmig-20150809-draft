# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openntpd/openntpd-20040824p.ebuild,v 1.5 2004/11/04 02:29:08 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Lightweight NTP server ported from OpenBSD"
HOMEPAGE="http://www.openntpd.org/"
SRC_URI="http://www.openntpd.org/dist/portable/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

DEPEND="virtual/libc"

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
	newexe ${FILESDIR}/openntpd.rc openntpd
	insinto /etc/conf.d
	newins ${FILESDIR}/openntpd.conf.d openntpd
}
