# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/upx/upx-1.21.ebuild,v 1.3 2002/07/11 06:30:16 drobbins Exp $

DESCRIPTION="upx is the Ultimate Packer for eXecutables"
SRC_URI="http://upx.sourceforge.net/download/${P}-src.tar.gz"
HOMEPAGE="http://upx.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="=dev-libs/ucl-1.01"
RDEPEND=${DEPEND}

src_compile() {
	cd ${S}/src
	export UCLDIR=/usr/src/ucl-1.01
	export HOME=/usr
	export EXTRA_DEFS=-DWITH_UCL
	export arch=foo
	emake -e || die
}

src_install() {
	dobin ${S}/src/upx
}

