# Copyright 1999-2002 Gentoo Technologies, Inc.      
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Christian Rubbert <ceed@xrc.de>
# $Header: /var/cvsroot/gentoo-x86/app-arch/bsdsfv/bsdsfv-1.0.12.ebuild,v 1.1 2002/01/27 07:24:58 blocke Exp $

S=${WORKDIR}/bsdsfv
DESCRIPTION="BSDSFV: All-in-one SFV checksum utility"
SRC_URI="http://prdownloads.sourceforge.net/bsdsfv/${P}.tar.gz"
HOMEPAGE="http://bsdsfv.sourceforge.net/"

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install () {

	dobin bsdsfv
	dodoc README MANUAL

}
