# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upx/upx-3.00.ebuild,v 1.2 2008/05/05 03:05:44 tester Exp $

DESCRIPTION="Ultimate Packer for eXecutables"
HOMEPAGE="http://upx.sourceforge.net/"
SRC_URI="x86? ( http://upx.sourceforge.net/download/${P}-i386_linux.tar.bz2 )
	amd64? ( http://upx.sourceforge.net/download/${P}-amd64_linux.tar.bz2 )
	ppc? ( http://upx.sourceforge.net/download/${P}-powerpc_linux.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""
RESTRICT="strip"

DEPEND="!app-arch/upx-ucl"

S=${WORKDIR}

src_install() {
	#the pre-compiled version works on gcc-3.2 systems
	# source version won't compile.
	cd ${P}*
	into /opt
	dobin upx || die
	doman upx.1
	dodoc upx.doc BUGS NEWS README* THANKS TODO
	dohtml upx.html
}
