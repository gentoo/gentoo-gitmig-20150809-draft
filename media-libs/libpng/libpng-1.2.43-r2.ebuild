# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpng/libpng-1.2.43-r2.ebuild,v 1.12 2010/07/09 10:26:53 ssuominen Exp $

EAPI=3
inherit libtool

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha arm ia64 m68k ppc s390 sh sparc"
IUSE=""

RDEPEND="sys-libs/zlib
	!media-libs/libpng:1.2"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

src_prepare() {
	elibtoolize
}

src_install() {
	emake DESTDIR="${D}" install || die
}
