# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/upx/upx-1.21.ebuild,v 1.4 2002/07/25 19:18:35 seemant Exp $

DESCRIPTION="upx is the Ultimate Packer for eXecutables"
SRC_URI="http://upx.sourceforge.net/download/${P}-src.tar.gz"
HOMEPAGE="http://upx.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=dev-libs/ucl-1.01"

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
