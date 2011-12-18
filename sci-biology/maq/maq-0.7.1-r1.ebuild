# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/maq/maq-0.7.1-r1.ebuild,v 1.5 2011/12/18 19:53:20 phajdan.jr Exp $

EAPI=4

inherit autotools eutils

DESCRIPTION="Mapping and Assembly with Qualities - mapping Solexa and SOLiD reads to reference sequences"
HOMEPAGE="http://maq.sourceforge.net/"
SRC_URI="
	mirror://sourceforge/${PN}/${P}.tar.bz2
	mirror://sourceforge/${PN}/calib-36.dat.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-flags.patch \
		"${FILESDIR}"/${P}-bfr-overfl.patch
	sed \
		-e '/ext_CFLAGS/s:-m64::g' \
		-i configure* || die
	eautoreconf
}

src_install() {
	default
	insinto /usr/share/maq
	doins "${WORKDIR}"/*.dat
	doman maq.1
	dodoc ${PN}.pdf
}
