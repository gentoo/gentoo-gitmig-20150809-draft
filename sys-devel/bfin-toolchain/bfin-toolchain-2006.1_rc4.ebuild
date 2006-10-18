# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bfin-toolchain/bfin-toolchain-2006.1_rc4.ebuild,v 1.2 2006/10/18 16:05:57 vapier Exp $

inherit rpm

DESCRIPTION="Compiler for Blackfin targets"
HOMEPAGE="http://blackfin.uclinux.org/"
SRC_URI="http://blackfin.uclinux.org/frs/download.php/914/blackfin-toolchain-06r1-4.i386.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="strip"

DEPEND=""

S=${WORKDIR}

src_install() {
	mv "${S}"/opt "${D}"/ || die
}
