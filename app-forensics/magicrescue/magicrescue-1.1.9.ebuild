# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/magicrescue/magicrescue-1.1.9.ebuild,v 1.2 2012/02/03 14:42:12 ago Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Find deleted files in block devices"
HOMEPAGE="http://www.itu.dk/people/jobr/magicrescue/"
SRC_URI="http://www.itu.dk/people/jobr/magicrescue/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	tc-export CC
}
