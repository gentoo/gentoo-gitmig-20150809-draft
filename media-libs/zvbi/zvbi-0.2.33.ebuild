# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/zvbi/zvbi-0.2.33.ebuild,v 1.7 2008/12/13 13:44:46 dertobi123 Exp $

inherit libtool

DESCRIPTION="VBI Decoding Library for Zapping"
SRC_URI="mirror://sourceforge/zapping/${P}.tar.bz2"
HOMEPAGE="http://zapping.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="X nls v4l dvb doc"

RDEPEND="X? ( x11-libs/libX11 )
	media-libs/libpng
	sys-libs/zlib
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	X? ( x11-libs/libXt )
	virtual/os-headers
	nls? ( sys-devel/gettext )
	doc? ( app-doc/doxygen )"

src_compile() {
	elibtoolize
	econf $(use_enable nls) \
		$(use_enable v4l) \
		$(use_enable dvb) \
		$(use_with X x) \
		$(use_with doc doxygen) \
		|| die "econf failed."
	emake || die "emake failed."
}

src_install () {
	emake DESTDIR="${D}" install || die "einstall failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
	use doc && dohtml -a png,gif,html,css doc/html/*
}
