# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpixman/libpixman-0.1.0.ebuild,v 1.1 2004/03/17 22:22:59 twp Exp $

DESCRIPTION="A generic library for manipulating pixel regions"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"
LICENSE="X11"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D}
}
