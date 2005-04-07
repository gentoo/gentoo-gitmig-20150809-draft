# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgconfig/pkgconfig-0.15.0.ebuild,v 1.24 2005/04/07 04:00:00 dostrow Exp $

inherit gnuconfig flag-o-matic

DESCRIPTION="Package Config system that manages compile/link flags for libraries"
HOMEPAGE="http://www.freedesktop.org/software/pkgconfig/"
SRC_URI="http://www.freedesktop.org/software/pkgconfig/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390 ppc-macos"
IUSE="hardened"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
	if use ppc64 && use hardened; then
		replace-flags -O[2-3] -O1
	fi
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README
}
