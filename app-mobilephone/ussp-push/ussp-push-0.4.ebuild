# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/ussp-push/ussp-push-0.4.ebuild,v 1.3 2005/08/16 22:51:11 malc Exp $

DESCRIPTION="OBEX object pusher for Linux"
HOMEPAGE="http://xmailserver.org/ussp-push.html"
SRC_URI="http://xmailserver.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="net-wireless/bluez-libs
	dev-libs/openobex"
RDEPEND="${DEPEND}"

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
