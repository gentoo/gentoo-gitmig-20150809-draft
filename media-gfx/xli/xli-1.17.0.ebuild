# Distributed under the terms of the GNU General Public License v2

S=${WORKDIR}/${P}
DESCRIPTION="X Load Image: view images or load them to root window"
SRC_URI="ftp://ftp.freebsd.org/pub/FreeBSD/ports/distfiles/${P}.tar.gz"
HOMEPAGE="http://pantransit.reptiles.org/prog/"

SLOT="0"
LICENSE="X11"
KEYWORDS="x86"

DEPEND="virtual/glibc \
		virtual/x11 \
		>=sys-libs/zlib-1.1.4
		>=media-libs/libpng-1.0.5 \
		>=media-libs/jpeg-6b-r2"

src_compile() {
	cp Imakefile Imakefile.orig
	sed -e "/^DEFINES =/s/$/ -DHAVE_GUNZIP/" < Imakefile.orig > Imakefile

	/usr/X11R6/bin/xmkmf || die

	cp Makefile Makefile.orig
	sed -e "/CDEBUGFLAGS =/s/=.*/= ${CFLAGS}/" < Makefile.orig > Makefile

	# This is a hack to avoid a parse error on /usr/include/string.h
	# when _BSD_SOURCE is defined. This may be a bug in that header.
	cp png.c png.c.orig
	sed -e "/^#include \"xli.h\"/i#undef _BSD_SOURCE" < png.c.orig > png.c

	emake || die
}

src_install () {
	into /usr
	dobin xli xlito
	dodoc README README.xloadimage ABOUTGAMMA TODO chkgamma.jpg
	newman xli.man xli.1
	newman xliguide.man xliguide.1
	newman xlito.man xlito.1
	dosym /usr/bin/xli /usr/bin/xview
	dosym /usr/bin/xli /usr/bin/xsetbg
	
	# is this even worth it? xrdb doesnt like this file; this is what
	# their install does, though.
	dodir /usr/X11R6/lib/X11/app-defaults
	cp /dev/null ${D}/usr/X11R6/lib/X11/app-defaults/Xli
	echo "path=/usr/X11R6/include/X11/bitmaps /usr/X11R6/include/X11/images" \
		>> ${D}/usr/X11R6/lib/X11/app-defaults/Xli
	echo "extension=.gif .jpg .rle .csun .msun .sun .face .xbm .bm"  \
		>> ${D}/usr/X11R6/lib/X11/app-defaults/Xli
	chmod a+r ${D}/usr/X11R6/lib/X11/app-defaults/Xli
}

