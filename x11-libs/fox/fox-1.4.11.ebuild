# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fox/fox-1.4.11.ebuild,v 1.2 2005/04/01 21:12:09 rphillips Exp $

IUSE="cups debug truetype opengl X tiff png jpeg zlib bzlib"
DESCRIPTION="C++ based Toolkit for developing Graphical User Interfaces easily and effectively"
SRC_URI="http://www.fox-toolkit.org/ftp/${P}.tar.gz"
HOMEPAGE="http://www.fox-toolkit.org"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~hppa ~alpha"
LICENSE="GPL-2"

DEPEND="virtual/libc
	virtual/x11
	truetype? ( >=media-libs/freetype-2 )
	opengl? ( virtual/opengl )
	tiff? ( media-libs/tiff )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	zlib? ( sys-libs/zlib )
	bzlib? ( app-arch/bzip2 )"


src_compile() {
	local myconf

	# Following line closes #61694
	CPPFLAGS="$CPPFLAGS -I/usr/include/freetype2" \
	econf \
		`use_with opengl` \
		`use_enable cups` \
		`use_enable debug` \
		`use_enable tiff` \
		`use_enable jpeg` \
		`use_enable png` \
		`use_enable zlib` \
		`use_enable bzlib bz2lib` \
		`use_with truetype xft` \
		`use_with X xshm` `use_with X xcursor` \
		${myconf} || die "Configuration Failed"

	emake || die "Parallel Make Failed"
}

src_install () {

	einstall

	dodoc README INSTALL LICENSE ADDITIONS AUTHORS TRACING

	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/fox/html/* ${D}/usr/share/doc/${PF}/html/
	rmdir ${D}/usr/fox/html
	rmdir ${D}/usr/fox
}
