# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/fnfx/fnfx-0.3.ebuild,v 1.1 2005/01/28 16:29:49 genstef Exp $

DESCRIPTION="Daemon and client allowing use of Toshiba special keys"
HOMEPAGE="http://fnfx.sourceforge.net/"
SRC_URI="mirror://sourceforge/fnfx/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_install() {
	make install DESTDIR=${D} || die "make install failed"

	exeinto /etc/init.d
	newexe ${FILESDIR}/fnfxd fnfxd

	dodoc AUTHORS README ChangeLog
}

pkg_postinst() {
	echo
	einfo
	einfo "The Fnfx Toshiba function key package has been installed."
	einfo
	einfo "If you would like the service to start automatically on boot"
	einfo "please execute the command rc-update add fnfxd default."
	einfo
	echo
}
