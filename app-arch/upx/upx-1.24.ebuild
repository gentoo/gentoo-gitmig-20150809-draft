# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upx/upx-1.24.ebuild,v 1.3 2003/02/13 05:57:57 vapier Exp $

S=${WORKDIR}/${P}-linux
DESCRIPTION="upx is the Ultimate Packer for eXecutables."
SRC_URI="http://upx.sourceforge.net/download/${P}-linux.tar.gz"
HOMEPAGE="http://upx.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RESTRICT="nostrip"

src_install() {
	#the pre-compiled version works on gcc-3.2 systems; source version won't compile.
	dobin upx
	doman upx.1
	dodoc upx.doc upx.html BUGS COPYING LICENSE NEWS README THANKS
}
