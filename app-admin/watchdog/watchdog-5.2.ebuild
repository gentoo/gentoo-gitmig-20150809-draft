# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/watchdog/watchdog-5.2.ebuild,v 1.23 2004/11/06 07:15:56 vapier Exp $

inherit eutils

DESCRIPTION="A software watchdog"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/daemons/watchdog/"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/daemons/watchdog/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-sundries.patch
	epatch ${FILESDIR}/${PV}-alpha.patch
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
	doexe ${FILESDIR}/watchdog
	insinto /etc/conf.d
	newins ${FILESDIR}/watchdog.conf.d watchdog
}

pkg_postinst() {
	einfo "To enable the start-up script run \"rc-update add watchdog boot\"."
	if [ ! -e ${ROOT}/dev/watchdog ] ; then
		ewarn "No /dev/watchdog found! Make sure your kernel has watchdog support"
		ewarn "compiled in or the kernel module is loaded. The watchdog service"
		ewarn "will not start at boot until your kernel is configured properly."
	fi
}
