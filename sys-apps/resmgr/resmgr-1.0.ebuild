# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/resmgr/resmgr-1.0.ebuild,v 1.2 2004/10/31 02:05:18 pylon Exp $

DESCRIPTION="Resource manager that will provide unprivileged users access to device files"
HOMEPAGE="http://rechner.lst.de/~okir/resmgr/"
SRC_URI="ftp://ftp.lst.de/pub/people/okir/resmgr/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="sys-apps/hotplug
	sys-libs/pam"

IUSE=""

src_compile() {
	emake CFLAGS="$CFLAGS" || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dosym $(basename ${D}/lib/libresmgr.so.*) /lib/libresmgr.so
	exeinto /etc/init.d
	newexe "${FILESDIR}/resmgrd.rc" resmgrd
	insinto /etc/conf.d
	newins "${FILESDIR}/resmgrd.confd" resmgrd
	exeinto /etc/hotplug/usb
	newexe "${FILESDIR}/desktopdev" desktopdev
	dodoc ANNOUNCE COPYING INSTALL README TODO
	dodoc "${FILESDIR}/README.gentoo"
}

pkg_postinst() {
	ewarn "You need to define access control lists in /etc/resmgr.conf"
	ewarn "For a start, it is probably a good idea to add a rule such as"
	ewarn "	 allow desktop tty=:0"
	ewarn "which will give everyone logged in via kdm/gdm access to"
	ewarn "resource class desktop."
	echo
	ewarn "Then start the daemon by running /etc/init.d/resmgrd start"
	ewarn "and add pam_resmgr.so to the PAM configuration file that"
	ewarn "controls your graphical login. Depending on your desktop,"
	ewarn "this will be /etc/pam.d/xdm, /etc/pam.d/gdm, /etc/pam.d/kdm,"
	ewarn "or /etc/pam.d/kde."
}
