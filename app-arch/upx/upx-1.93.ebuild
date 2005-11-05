# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/upx/upx-1.93.ebuild,v 1.1 2005/11/05 07:56:20 matsuu Exp $

MY_P="${P}-linux_i386"
DESCRIPTION="Ultimate Packer for eXecutables"
HOMEPAGE="http://upx.sourceforge.net/"
SRC_URI="http://upx.sourceforge.net/download/unstable/${MY_P}.tar.gz"
#SRC_URI="http://upx.sourceforge.net/download/${P}-linux.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~s390 ~x86"
IUSE=""
RESTRICT="nostrip"

DEPEND="!app-arch/upx-ucl"

S="${WORKDIR}/${MY_P}"

src_install() {
	#the pre-compiled version works on gcc-3.2 systems
	# source version won't compile.
	into /opt
	dobin upx || die
	doman upx.1
	dodoc upx.doc BUGS NEWS README* THANKS TODO
	dohtml upx.html
}
