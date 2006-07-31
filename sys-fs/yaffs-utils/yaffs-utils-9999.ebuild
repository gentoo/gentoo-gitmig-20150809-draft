# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/yaffs-utils/yaffs-utils-9999.ebuild,v 1.1 2006/07/31 05:25:59 vapier Exp $

ECVS_SERVER="cvs.aleph1.co.uk:/home/aleph1/cvs"
ECVS_MODULE="yaffs"

inherit eutils cvs

DESCRIPTION="tools for generating YAFFS images"
HOMEPAGE="http://www.aleph1.co.uk/yaffs/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${ECVS_MODULE}/utils

src_unpack() {
	cvs_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	dobin mkyaffs || die
	dodoc ../README
}
