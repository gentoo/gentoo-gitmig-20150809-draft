# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Will Glynn <delta407@lerfjhax.com>
# $Header: /var/cvsroot/gentoo-x86/app-misc/upx/upx-1.21.ebuild,v 1.1 2002/06/21 22:09:06 rphillips Exp $

DESCRIPTION="The Ultimate Packer for eXecutables"
SRC_URI="http://upx.sourceforge.net/download/${P}-src.tar.gz"
HOMEPAGE="http://upx.sourceforge.net/"
LICENSE="GPL"
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

