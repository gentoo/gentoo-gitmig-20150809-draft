#Copyright 2002 Gentoo Technologies, Inc.
#Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-fs/ncpfs/ncpfs-2.2.0.19.ebuild,v 1.2 2002/07/17 09:52:23 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Provides Access to Netware services using the NCP protocol (Kernel support must be activated!)"
SRC_URI="ftp://platan.vc.cvut.cz/pub/linux/ncpfs/latest/${P}.tar.gz"
HOMEPAGE="ftp://platan.vc.cvut.cz/pub/linux/ncpfs/latest/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

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
