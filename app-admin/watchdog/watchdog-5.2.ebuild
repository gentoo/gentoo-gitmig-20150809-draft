# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/watchdog/watchdog-5.2.ebuild,v 1.18 2004/06/25 23:06:54 vapier Exp $

inherit eutils

DESCRIPTION="A software watchdog"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/daemons/watchdog/"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/daemons/watchdog/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/sundries.diff || die "patch failed"
	epatch ${FILESDIR}/${P}-alpha.diff || die "patch failed"
}

src_compile() {
	econf \
		--sysconfdir=/etc/watchdog \
		--with-configfile=/etc/watchdog/watchdog.conf \
		|| die "econf failed"
	emake || die
}

src_install() {
	dodir /etc/watchdog
	make DESTDIR="${D}" install || die
	exeinto /etc/init.d
	doexe "${FILESDIR}/${PVR}/watchdog"
}

pkg_postinst() {
	einfo "To enable the start-up script run \"rc-update add watchdog boot\"."
	if [ ! -e ${ROOT}/dev/watchdog ]
	then
		ewarn "No /dev/watchdog found! Make sure your kernel has watchdog support"
		ewarn "compiled in or the kernel module is loaded. The watchdog service"
		ewarn "will not start at boot until your kernel is configured properly."
	fi
}
