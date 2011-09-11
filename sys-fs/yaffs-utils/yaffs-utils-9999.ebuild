# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/yaffs-utils/yaffs-utils-9999.ebuild,v 1.3 2011/09/11 19:01:47 vapier Exp $

EAPI="2"

EGIT_REPO_URI="git://www.aleph1.co.uk/yaffs"
EGIT_UNPACK_DIR=${WORKDIR}

inherit eutils git toolchain-funcs

DESCRIPTION="tools for generating YAFFS images"
HOMEPAGE="http://www.aleph1.co.uk/yaffs/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

S=${WORKDIR}/utils

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	tc-export CC
}

src_install() {
	dobin mkyaffs || die
	dodoc ../README
}
