# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fox/fox-1.2.6-r3.ebuild,v 1.6 2006/08/19 20:57:13 weeve Exp $

IUSE="cups debug truetype opengl"
DESCRIPTION="C++ based Toolkit for developing Graphical User Interfaces easily and effectively"
SRC_URI="http://www.fox-toolkit.org/ftp/${P}.tar.gz"
HOMEPAGE="http://www.fox-toolkit.org"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ppc ppc64 sparc x86"
LICENSE="GPL-2"

RDEPEND="|| ( ( x11-libs/libXrandr
			x11-libs/libXcursor
		)
		virtual/x11
	)
	truetype? ( >=media-libs/freetype-2.1.5-r1 virtual/xft )
	opengl? ( virtual/opengl virtual/glu )"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xextproto
			x11-libs/libXt
		)
		virtual/x11
	)"


src_compile() {
	local myconf

	use opengl || myconf="$myconf --with-opengl=no" #default enabled
	myconf="$myconf `use_enable cups`"              #default disabled
	myconf="$myconf `use_enable debug`"             #default disabled
	use truetype && myconf="$myconf --with-xft"     #default disabled

	# Following line closes #61694
	CPPFLAGS="$CPPFLAGS -I/usr/include/freetype2" \
	econf ${myconf}
	emake || die "Parallel Make Failed"
}

src_install () {
	make DESTDIR="${D}" install || die "Installation Failed"

	dodoc README INSTALL LICENSE ADDITIONS AUTHORS TRACING

	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/fox/html/* ${D}/usr/share/doc/${PF}/html/
	rmdir ${D}/usr/fox/html
	rmdir ${D}/usr/fox
}
