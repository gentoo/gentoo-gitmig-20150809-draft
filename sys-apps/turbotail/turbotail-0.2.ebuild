# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/turbotail/turbotail-0.2.ebuild,v 1.2 2005/08/06 09:10:18 dholm Exp $

inherit eutils

DESCRIPTION="drop-in replacement for 'tail' which uses the kernel DNOTIFY-api"
HOMEPAGE="http://www.vanheusden.com/Linux/"
SRC_URI="http://www.vanheusden.com/Linux/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
DEPEND=""

src_compile() {
	# enforce our CFLAGS
	emake CFLAGS="-Wall ${CFLAGS} -DVERSION=\"${VERSION}\"" || die "emake failed"
}

src_install() {
	dobin turbotail || die "install failed"
	dodoc readme.txt
}
