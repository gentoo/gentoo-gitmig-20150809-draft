# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upx/upx-2.02.ebuild,v 1.3 2007/07/02 13:40:23 peper Exp $

DESCRIPTION="Ultimate Packer for eXecutables"
HOMEPAGE="http://upx.sourceforge.net/"
SRC_URI="x86? ( http://upx.sourceforge.net/download/${P}-i386_linux.tar.gz )
	amd64? ( http://upx.sourceforge.net/download/${P}-amd64_linux.tar.gz )
	ppc? ( http://upx.sourceforge.net/download/${P}-powerpc_linux.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
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
