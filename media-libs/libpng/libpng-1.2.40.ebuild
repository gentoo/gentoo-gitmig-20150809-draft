# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.2.40.ebuild,v 1.14 2010/05/11 09:38:55 ssuominen Exp $

# last of the unslotted libpng ebuild, in weird slot too, please kill this soon
# as KEYWORDS allow it.

EAPI=3
inherit libtool

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/libpng/${P}.tar.bz2"

LICENSE="as-is"
SLOT="1.2"
KEYWORDS="alpha arm ia64 m68k ppc s390 sh sparc x86"
IUSE=""

DEPEND="sys-libs/zlib
	!>=media-libs/libpng-1.2.40-r1"

src_prepare() {
	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die
}
