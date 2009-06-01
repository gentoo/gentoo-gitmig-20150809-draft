# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audiocompress/audiocompress-1.5.2-r1.ebuild,v 1.2 2009/06/01 18:18:03 ssuominen Exp $

inherit eutils

MY_P="AudioCompress-${PV}"
IUSE="esd"
DESCRIPTION="Very gentle 1-band dynamic range compressor"
HOMEPAGE="http://beesbuzz.biz/code/"
SRC_URI="http://beesbuzz.biz/code/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

RDEPEND=""
DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	emake clean

	epatch "${FILESDIR}"/${P}-gentoo.patch \
		"${FILESDIR}"/${P}-esd.patch
}

src_compile() {
	emake AudioCompress || die "emake AudioCompress failed"
}

src_install() {
	dobin AudioCompress || die "dobin failed"
	dodoc ChangeLog README TODO
}
