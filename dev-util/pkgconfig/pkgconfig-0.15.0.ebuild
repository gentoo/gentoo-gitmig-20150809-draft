# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgconfig/pkgconfig-0.15.0.ebuild,v 1.13 2003/12/29 03:23:16 kumba Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Package Config system that manages compile/link flags for libraries"
SRC_URI="http://www.freedesktop.org/software/pkgconfig/releases/${P}.tar.gz"
HOMEPAGE="http://www.freedesktop.org/software/pkgconfig/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha arm hppa amd64 ia64 ppc64 mips"

IUSE=""
DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
