# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ussp-push/ussp-push-0.4.ebuild,v 1.2 2005/11/27 17:30:34 brix Exp $

DESCRIPTION="OBEX object pusher for Linux"
HOMEPAGE="http://xmailserver.org/ussp-push.html"
SRC_URI="http://xmailserver.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="net-wireless/bluez-libs
	dev-libs/openobex"

src_unpack(){
	unpack ${A}

	sed -i -e "s/^CFLAGS=.*/& ${CFLAGS}/" ${S}/Makefile
}

src_install() {
	dobin ${PN}
	dodoc doc/README
	dohtml doc/*.html
}

pkg_postinst() {
	einfo
	einfo "You can use ussp-push in two ways: "
	einfo "1. rfcomm bind /dev/rcomm0 00:11:22:33:44:55 10"
	einfo "   ussp-push /dev/rfcomm0 localfile remotefile"
	einfo "2. ussp-push \"BTDeviceName\"@10 localfile remotefile"
	einfo
	einfo "See README for details."
	einfo
}
