# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openntpd/openntpd-0.20040824p.ebuild,v 1.1 2004/11/04 03:12:18 vapier Exp $

inherit eutils

MY_P="${P}-${PV/0.}"
DESCRIPTION="Lightweight NTP server ported from OpenBSD"
HOMEPAGE="http://www.openntpd.org/"
SRC_URI="http://www.openntpd.org/dist/portable/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

RDEPEND="virtual/libc
	!net-misc/ntp"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51"

S=${WORKDIR}/${MY_P}

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

	newinitd ${FILESDIR}/openntpd.rc openntpd
	newconfd ${FILESDIR}/openntpd.conf.d openntpd
}
