# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: system@gentoo.org
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB/DirectFB-0.9.11.ebuild,v 1.1 2002/06/06 10:01:47 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="DirectFB is a thin library on top of the Linux framebuffer devices"
SRC_URI="http://www.directfb.org/download/DirectFB/${P}.tar.gz"
HOMEPAGE="http://www.directfb.org"

DEPEND="sys-devel/perl
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	mpeg? ( media-libs/libmpeg3 )
	flash? ( >=media-libs/libflash-0.4.10 )
	truetype? ( >=media-libs/freetype-2.0.1 )
	quicktime? ( media-libs/quicktime4linux )"
#	avi? ( >=media-video/avifile-0.7.4.20020426-r2 )"


src_compile() {
	
	local myconf=""
	
	# Bug in the ./configure script that breaks if you
	# have --enable-mmx
	use mmx || myconf="${myconf} --disable-mmx"

# Still do not work currently
#	use avi	\
#		&& myconf="${myconf} --enable-avifile"	\
#		|| myconf="${myconf} --disable-avifile"
	myconf="${myconf} --disable-avifile"
	
	use mpeg \
		&& myconf="${myconf} --with-libmpeg3=/usr/include/libmpeg3" \
		|| myconf="${myconf} --disable-libmpeg3"

	use jpeg \
		&& myconf="${myconf} --enable-jpeg" \
		|| myconf="${myconf} --disable-jpeg"

	use png \
		&& myconf="${myconf} --enable-png" \
		|| myconf="${myconf} --disable-png"

	use gif \
		&& myconf="${myconf} --enable-gif" \
		|| myconf="${myconf} --disable-gif"

	use truetype \
		&& myconf="${myconf} --enable-freetype" \
		|| myconf="${myconf} --disable-freetype"
	
	econf ${myconf} || die

	use mpeg && ( \
		cd ${S}/interfaces/IDirectFBVideoProvider
		patch < ${FILESDIR}/${PN}-gentoo-patch Makefile
		cd ${S}
	)

	make || die

}

src_install () {
	
	insinto /etc
	doins fb.modes

	make 	\
		DESTDIR=${D}	\
		install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README* TODO
	dohtml -r docs/html
}

