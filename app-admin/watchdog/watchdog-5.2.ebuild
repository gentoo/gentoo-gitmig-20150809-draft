# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/watchdog/watchdog-5.2.ebuild,v 1.14 2003/09/07 22:11:14 lanius Exp $

inherit eutils

IUSE=""
DESCRIPTION="A software watchdog."
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/daemons/watchdog/"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/daemons/watchdog/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/sundries.diff || die "patch failed"
	epatch ${FILESDIR}/${P}-alpha.diff || die "patch failed"
}

src_compile() {
	# Two configure switches have been added to use /etc/watchdog
	econf \
		--sysconfdir=/etc/watchdog \
		--with-configfile=/etc/watchdog/watchdog.conf
	emake || die
}

src_install() {
	dodir /etc/watchdog
	make DESTDIR="${D}" install || die

	exeinto /etc/init.d
	doexe "${FILESDIR}/${PVR}/watchdog"
}

pkg_postinst() {
	einfo
	einfo "To enable the start-up script run \"rc-update add watchdog boot\"."
	einfo
	if [ ! -e /dev/watchdog ]
	then
		ewarn
		ewarn "No /dev/watchdog found! Make sure your kernel has watchdog support"
		ewarn "compiled in or the kernel module is loaded. The watchdog service"
		ewarn "will not start at boot until your kernel is configured properly."
		ewarn
	fi
}
