# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openntpd/openntpd-3.6_p1.ebuild,v 1.5 2004/12/11 17:58:07 vapier Exp $

inherit eutils

MY_P=${P/_/}
DESCRIPTION="Lightweight NTP server ported from OpenBSD"
HOMEPAGE="http://www.openntpd.org/"
SRC_URI="mirror://openbsd/OpenNTPD/portable/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND="virtual/libc
	!<=net-misc/ntp-4.2.0-r2"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	enewgroup ntp 123
	enewuser ntp 123 /bin/false /var/empty ntp
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i '/NTPD_USER/s:_ntp:ntp:' ntpd.h || die
	epatch ${FILESDIR}/${PV}-ntpd.8.patch
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc ChangeLog CREDITS README

	newinitd ${FILESDIR}/openntpd.rc ntpd
	newconfd ${FILESDIR}/openntpd.conf.d ntpd
}
