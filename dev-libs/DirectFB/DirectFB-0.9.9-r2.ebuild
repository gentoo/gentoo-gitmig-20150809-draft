# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: system@gentoo.org
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB/DirectFB-0.9.9-r2.ebuild,v 1.3 2002/04/16 03:49:57 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="DirectFB is a thin library on top of the Linux framebuffer devices"
SRC_URI="http://www.directfb.org/download/DirectFB/${P}.tar.gz
	mpeg? http://heroinewarrior.com/libmpeg3-1.5.tar.gz"
HOMEPAGE="http://www.directfb.org"

DEPEND="sys-devel/perl
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	flash? ( >=media-libs/libflash-0.4.10 )
	truetype? ( >=media-libs/freetype-2.0.1 )
	quicktime? ( media-libs/quicktime4linux )"
#	avi? ( =media-video/avifile-0.6* )

RDEPEND="${DEPEND}"

src_compile() {
	
	# If user wants libmpeg3 support, then compile that first
	use mpeg && ( \
		cd ${WORKDIR}/libmpeg3
		make
		cd ${S}
	)

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
		&& myconf="${myconf} --with-libmpeg3=${WORKDIR}/libmpeg3" \
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
	
	if [ "$DEBUG" ] ; then
      myconf="${myconf} --enable-debug"
    else
      myconf="${myconf} --disable-debug"
    fi

	
    ./configure	\
		--prefix=/usr \
		${myconf} || die

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
