# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgconfig/pkgconfig-0.15.0.ebuild,v 1.22 2004/10/23 07:41:23 mr_bones_ Exp $

inherit gnuconfig

DESCRIPTION="Package Config system that manages compile/link flags for libraries"
HOMEPAGE="http://www.freedesktop.org/software/pkgconfig/"
SRC_URI="http://www.freedesktop.org/software/pkgconfig/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390 ppc-macos"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
