# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upx/upx-1.24-r1.ebuild,v 1.7 2005/01/01 12:01:46 eradicator Exp $

S=${WORKDIR}/${P}-linux
DESCRIPTION="Ultimate Packer for eXecutables"
HOMEPAGE="http://upx.sourceforge.net/"
SRC_URI="http://upx.sourceforge.net/download/${P}-linux.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 s390"
IUSE=""
RESTRICT="nostrip"

DEPEND="!app-arch/upx-ucl"

src_install() {
	#the pre-compiled version works on gcc-3.2 systems
	# source version won't compile.
	into /opt
	dobin upx || die
	doman upx.1
	dodoc upx.doc upx.html BUGS NEWS README THANKS
}
