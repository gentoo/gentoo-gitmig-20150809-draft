# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dhcping/dhcping-1.2.ebuild,v 1.3 2007/04/24 06:39:47 ticho Exp $

DESCRIPTION="Utility for sending a dhcp request to a dhcp server to see if it is responding."
HOMEPAGE="http://www.mavetju.org/unix/general.php"
SRC_URI="http://www.mavetju.org/download/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 x86"
IUSE=""

DEPEND=""

src_compile() {
	econf || die "econf failed"
}

src_install() {
	make DESTDIR=${D} install || die
}
