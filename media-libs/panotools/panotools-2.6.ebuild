# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/panotools/panotools-2.6.ebuild,v 1.3 2004/07/14 20:23:19 agriffis Exp $

inherit eutils

DESCRIPTION="Helmut Dersch's panorama toolbox library"

HOMEPAGE="http://www.path.unimelb.edu.au/~dersch/
		http://bugbear.blackfish.org.uk/~bruno/panorama-tools/"
SRC_URI="http://dev.gentoo.org/~lu_zero/distfiles/${P}.tar.bz2
		http://dev.gentoo.org/~lu_zero/distfiles/${P}-patches-${PR}.patch.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND="media-libs/libpng
		media-libs/tiff
		media-libs/jpeg
		sys-libs/zlib"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	epatch ${DISTDIR}/${P}-patches-${PR}.patch.bz2
}

src_compile() {
	emake CFLAGS="$CFLAGS -D__Ansi__=1" || die
}

src_install() {
	insinto /usr/lib
	doins libpano12.so
	insinto /usr/include/pano12
	doins *.h
}
