# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htmlinc/htmlinc-1.0_beta1.ebuild,v 1.5 2002/11/06 16:07:48 vapier Exp $

DESCRIPTION="HTML Include System by Ulli Meybohm"
HOMEPAGE="http://www.meybohm.de/"
SRC_URI="http://meybohm.de/files/${PN}.tar.gz"

KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"
S=${WORKDIR}/htmlinc

src_unpack() {
	unpack ${A}
	patch -p0 < ${FILESDIR}/htmlinc-gcc3-gentoo.patch || die "could not patch"
}

src_compile() {
	emake CFLAGS="${CXXFLAGS} -Wall" || die
}

src_install() {
	dobin htmlinc
}
