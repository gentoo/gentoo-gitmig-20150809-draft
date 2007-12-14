# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/tapecat/tapecat-1.0.0.ebuild,v 1.3 2007/12/14 17:28:14 nixnut Exp $

DESCRIPTION="tapecat is a tape utility used to describe the physical content of a tape."
HOMEPAGE="http://www.inventivetechnology.at/tapecat/"
SRC_URI="http://downloads.inventivetechnology.at/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""
DEPEND="sys-apps/file"
RDEPEND="${RDEPEND}"

src_compile() {
	emake CFLAGS="${CFLAGS} -Wall -ansi"
}

src_install() {
	dobin tapecat
	doman tapecat.1
}
