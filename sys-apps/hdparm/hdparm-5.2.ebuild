# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/sys-apps/hdparm/hdparm-5.2.ebuild,v 1.1 2002/05/03 20:39:23 drobbins Exp

S=${WORKDIR}/${P}
DESCRIPTION="Utility to change hard drive performance parameters"
SRC_URI="http://metalab.unc.edu/pub/Linux/system/hardware/${P}.tar.gz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/system/hardware/"
KEYWORDS="x86"
SLOT="0"
DEPEND="virtual/glibc"
LICENSE="BSD"

src_compile() {
	emake || die "compile error"
}

src_install() {
	dosbin hdparm contrib/idectl
	doman hdparm.8
	dodoc hdparm.lsm Changelog README.acoustic hdparm-sysconfig
}
