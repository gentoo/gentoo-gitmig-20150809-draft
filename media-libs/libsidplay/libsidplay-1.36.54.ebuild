# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libsidplay/libsidplay-1.36.54.ebuild,v 1.3 2002/08/14 13:08:10 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="C64 SID player library"
HOMEPAGE="http://www.geocities.com/SiliconValley/Lakes/5147/sidplay/linux.html"
SRC_URI="http://www.geocities.com/SiliconValley/Lakes/5147/sidplay/packages/${P}.tgz"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING DEVELOPER INSTALL
}
