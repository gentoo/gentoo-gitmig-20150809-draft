# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-wakeup/xmms-wakeup-0.15.ebuild,v 1.4 2004/07/19 20:17:15 eradicator Exp $

IUSE=""

DESCRIPTION="XMMS Wake-up Call is a client & server program which allows you to run XMMS remotely, intended to be used as a wake-up call."
HOMEPAGE="http://xmms-wake-up.sourceforge.net"
SRC_URI="mirror://sourceforge/xmms-wake-up/xmms-wakeup-0.15.tar.gz"

KEYWORDS="x86 amd64 sparc ~ppc"
SLOT="0"

LICENSE="GPL-2"

DEPEND="media-sound/xmms"

src_compile() {
	emake all || die
}

src_install() {
	exeinto /usr/bin
	doexe xmms-wakeup-client xmms-wakeup-server
	dodoc README CHANGELOG
}

pkg_postinst() {
	einfo ""
	einfo "Server is run with xmms-wakeup-server"
	einfo "Client is run with xmms-wakeup-client"
	einfo "Make sure to read the README for more information."
	einfo ""
}
