# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/fnfx/fnfx-0.3.ebuild,v 1.4 2007/04/28 17:48:39 swegener Exp $

DESCRIPTION="Daemon and client allowing use of Toshiba special keys"
HOMEPAGE="http://fnfx.sourceforge.net/"
SRC_URI="mirror://sourceforge/fnfx/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

src_install() {
	make install DESTDIR=${D} || die "make install failed"

	newinitd ${FILESDIR}/fnfxd fnfxd

	dodoc AUTHORS README ChangeLog
}

pkg_postinst() {
	elog
	elog "If you would like the service to start automatically on boot"
	elog "please execute the command rc-update add fnfxd default."
	elog
}
