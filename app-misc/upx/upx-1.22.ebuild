# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}
DESCRIPTION="upx is the Ultimate Packer for eXecutables."
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
	dodoc BUGS COPYING LICENSE LOADER.TXT NEWS PROJECTS README README.SRC THANKS
}
