# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/cpuburn/cpuburn-1.4.ebuild,v 1.4 2003/06/29 15:43:52 aliz Exp $

DESCRIPTION="This program is designed to heavily load CPU chips [testing purposes]"
HOMEPAGE="http://users.ev1.net/~redelm/"

MY_P="${PV/./_}"
SRC_URI="http://users.ev1.net/~redelm/cpuburn_${MY_P}_tar.gz"
S="${WORKDIR}/${P}"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86 -ppc -sparc  -alpha"

RESTRICT="nostrip"
DEPEND="sys-devel/gcc"
RDEPEND=""

src_unpack() {
	#for some reason he has it _tar instead of .tar ...
	unpack ${A}
	cd ${WORKDIR}
	tar -xf cpuburn_${MY_P}_tar
}

src_compile() {
	emake || die
}

src_install() {
	dodoc Design README
	dobin burn{BX,K6,K7,MMX,P5,P6}
}
