# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htmlinc/htmlinc-1.0_beta1.ebuild,v 1.4 2002/09/16 09:43:47 mkennedy Exp $

DESCRIPTION="HTML Include System by Ulli Meybohm"
HOMEPAGE="http://www.meybohm.de/"
KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/glibc"
RDEPEND=${DEPEND}
SRC_URI="http://meybohm.de/files/${PN}.tar.gz"
S=${WORKDIR}/htmlinc

src_unpack() {
	unpack ${PN}.tar.gz
	patch -p0 < ${FILESDIR}/htmlinc-gcc3-gentoo.patch
}

src_compile() {
	emake CFLAGS="${CXXFLAGS} -Wall" || die
}

src_install () {
	dobin htmlinc
}
