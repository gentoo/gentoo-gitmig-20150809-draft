# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/watchdog/watchdog-5.2.ebuild,v 1.5 2002/07/17 20:43:17 drobbins Exp $

DESCRIPTION="A software watchdog."
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/daemons/watchdog/"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/daemons/watchdog/${P}.tar.gz"
SLOT="0"
S="${WORKDIR}/${P}"
LICENSE="GPL-2"

src_compile() {
    # Two configure switches have been added to use /etc/watchdog
    ./configure \
        --host=${CHOST} \
        --prefix=/usr \
        --sysconfdir=/etc/watchdog \
        --with-configfile=/etc/watchdog/watchdog.conf \
        --infodir=/usr/share/info \
        --mandir=/usr/share/man || die "./configure failed"
    emake || die
}

src_install () {
    dodir /etc/watchdog
    make DESTDIR="${D}" install || die

    exeinto /etc/init.d
    doexe "${FILESDIR}/${PVR}/watchdog"
}

pkg_postinst () {
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
