# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libquicktime/libquicktime-0.9.2_pre1.ebuild,v 1.6 2003/02/14 19:42:41 seemant Exp $

inherit libtool eutils

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A library based on quicktime4linux with extensions"
HOMEPAGE="http://libquicktime.sourceforge.net/"
SRC_URI="mirror://sourceforge/libquicktime/${MY_P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86"

IUSE="oggvorbis png jpeg"

DEPEND=">=sys-apps/sed-4.0.5
	media-libs/libdv
	=x11-libs/gtk+-1.2*
	png? ( media-libs/libpng )
	jpeg ( media-libs/jpeg )
	oggvorbis? ( media-libs/libvorbis )"

PROVIDE="virtual/quicktime"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:\(have_libavcodec=\)true:\1false:g" \
		configure.ac
}

src_compile() {

	ebegin "Regenerating configure script..."
	autoconf
	eend
	elibtoolize

	local myconf
	
	use mmx \
		&& myconf="${myconf} --enable-mmx" \
		|| myconf="${myconf} --disable-mmx"

	econf ${myconf}
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
