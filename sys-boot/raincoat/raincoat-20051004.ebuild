# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/raincoat/raincoat-20051004.ebuild,v 1.1 2005/10/04 21:08:18 gimli Exp $

DESCRIPTION="Flash the Xbox boot chip"
HOMEPAGE="http://www.xbox-linux.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

src_compile() {
	emake || die
}

src_install() {
	dodir /etc
	insinto /etc
	doins etc/raincoat.conf
	dodoc docs/README
	dobin bin/raincoat || die
}
