# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/nurbs++/nurbs++-3.0.11.ebuild,v 1.8 2004/03/19 07:56:04 mr_bones_ Exp $

DESCRIPTION="NURBS surfaces manipulation library"
HOMEPAGE="http://libnurbs.sourceforge.net/"
SRC_URI="mirror://sourceforge/libnurbs/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="3"
KEYWORDS="x86 sparc"
IUSE="debug" #opengl

DEPEND="virtual/x11
	dev-lang/perl"
	#media-gfx/imagemagick # doesn't work yet either
	# opengl? ( virtual/opengl ) # doesn't work yet

src_compile() {
	local myconf=""
	#use opengl \
	#	&& myconf="${myconf} --with-opengl=/usr" \
	#	|| myconf="${myconf} --without-opengl"

	./configure \
		--with-x \
		--prefix=/usr \
		`use_enable debug` \
		`use_enable debug exception` \
		`use_enable debug verbose-exception` \
		${myconf} \
		|| die # --with-magick
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
