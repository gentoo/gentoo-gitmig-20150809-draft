# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: system@gentoo.org
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB/DirectFB-0.9.10.ebuild,v 1.1 2002/04/27 00:36:05 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="DirectFB is a thin library on top of the Linux framebuffer devices"
SRC_URI="http://www.directfb.org/download/DirectFB/${P}.tar.gz"
HOMEPAGE="http://www.directfb.org"

DEPEND="sys-devel/perl
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	mpeg? (media-libs/libmpeg3 )
	flash? ( >=media-libs/libflash-0.4.10 )
	truetype? ( >=media-libs/freetype-2.0.1 )
	quicktime? ( media-libs/quicktime4linux )"
#	avi? ( =media-video/avifile-0.6* )

RDEPEND="${DEPEND}"

src_compile() {
	
	local myconf
	
	use mmx	\
		&& myconf="${myconf} --enable-mmx"	\
		|| myconf="${myconf} --disable-mmx"

# avifile that is in portage currently does not work with directfb
# an older one in the 0.6.0 series is required.
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
	
    ./configure	\
		--prefix=/usr \
		${myconf} || die

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
