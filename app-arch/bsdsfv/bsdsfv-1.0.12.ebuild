# Copyright 1999-2002 Gentoo Technologies, Inc.      
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/bsdsfv/bsdsfv-1.0.12.ebuild,v 1.5 2002/07/17 20:44:57 drobbins Exp $

S=${WORKDIR}/bsdsfv
DESCRIPTION="BSDSFV: All-in-one SFV checksum utility"
SRC_URI="mirror://sourceforge/bsdsfv/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://bsdsfv.sourceforge.net/"
LICENSE="BSD"

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install () {

	dobin bsdsfv
	dodoc README MANUAL

}
