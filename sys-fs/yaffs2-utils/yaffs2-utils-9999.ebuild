# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/yaffs2-utils/yaffs2-utils-9999.ebuild,v 1.2 2009/09/19 14:55:22 vapier Exp $

ECVS_SERVER="cvs.aleph1.co.uk:/home/aleph1/cvs"
ECVS_MODULE="yaffs2"

inherit eutils cvs

DESCRIPTION="tools for generating YAFFS images"
HOMEPAGE="http://www.aleph1.co.uk/yaffs/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""

S=${WORKDIR}/${ECVS_MODULE}/utils

src_unpack() {
	cvs_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_install() {
	dobin mkyaffsimage mkyaffs2image || die
}
