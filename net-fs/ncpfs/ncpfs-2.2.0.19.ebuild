# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/ncpfs/ncpfs-2.2.0.19.ebuild,v 1.9 2004/07/14 23:52:54 agriffis Exp $

DESCRIPTION="Provides Access to Netware services using the NCP protocol (Kernel support must be activated!)"
SRC_URI="ftp://platan.vc.cvut.cz/pub/linux/ncpfs/latest/${P}.tar.gz"
HOMEPAGE="ftp://platan.vc.cvut.cz/pub/linux/ncpfs/latest/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND=""

src_compile() {

	econf || die "./configure failed"
	emake || die
}

src_install () {
	# directory ${D}/lib/security needs to be created or the install fails
	dodir /lib/security
	make DESTDIR=${D} install || die
}
