# Copyright 1999-2002 Gentoo Technologies, Inc.      
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Christian Rubbert <ceed@xrc.de>
# $Header: /var/cvsroot/gentoo-x86/app-arch/bsdsfv/bsdsfv-1.0.12.ebuild,v 1.2 2002/05/27 17:27:34 drobbins Exp $

S=${WORKDIR}/bsdsfv
DESCRIPTION="BSDSFV: All-in-one SFV checksum utility"
SRC_URI="mirror://sourceforge/bsdsfv/${P}.tar.gz"
HOMEPAGE="http://bsdsfv.sourceforge.net/"

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install () {

	dobin bsdsfv
	dodoc README MANUAL

}
