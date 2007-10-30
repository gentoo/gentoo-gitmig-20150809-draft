# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/inputd/inputd-0.1.1.ebuild,v 1.4 2007/10/30 07:29:46 killerfox Exp $

inherit eutils

DESCRIPTION="inputd is a user-space daemon to emulate key presses trough other
key combinations"
HOMEPAGE="http://hansmi.ch/software/inputd"
SRC_URI="http://hansmi.ch/download/inputd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~ppc64"
IUSE=""

DEPEND=">=dev-libs/glib-2.10
	>=sys-kernel/linux-headers-2.6.16"
RDEPEND="sys-fs/udev
	virtual/logger"

src_install() {
	emake DESTDIR="${D}" install || die 'installation failed.'

	newinitd "${FILESDIR}/inputd.init" inputd
	dodoc README NEWS doc/FAQ

	insinto /etc
	doins doc/inputd.conf
}

pkg_postinst() {
	ewarn "The configuration syntax has slightly changed between "
	ewarn "inputd 0.0.x and 0.1.x. Please make sure every statement "
	ewarn "ends with a semicolon (;)."
	ewarn
	ewarn "If you encounter problem after an upgrade to >=udev-116-r1 "
	ewarn "please note that the path from /dev/misc/uinput might be changed to "
	ewarn "/dev/input/uinput"
}
