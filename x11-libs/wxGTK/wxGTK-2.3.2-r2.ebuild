# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxGTK/wxGTK-2.3.2-r2.ebuild,v 1.6 2002/08/14 13:05:59 murphy Exp $

S=${WORKDIR}/${P}

DESCRIPTION="GTK+ version of wxWindows, a cross-platform C++ GUI toolkit."

SRC_URI="mirror://sourceforge/wxwindows/${P}.tar.bz2"
LICENSE="LGPL-2"
SLOT="2.3"
KEYWORDS="x86 ppc sparc sparc64"

HOMEPAGE="http://www.wxwindows.org/"

DEPEND="dev-libs/libunicode
	media-libs/netpbm
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )
	odbc? ( dev-db/unixODBC  )
	opengl? ( virtual/opengl )"

use gtk		\
	&& DEPEND="${DEPEND} =x11-libs/gtk+-1.2*"	\
	|| DEPEND="${DEPEND} x11-libs/openmotif"

RDEPEND="nls? ( sys-devel/gettext )"
	

src_compile() {

	
	local myconf
	#--with-gtk enabled by default, if you want to build against motif,
	#replace --with-gtk with --with-motif and --without-gtk. You will
	#also need openmotif installed.	Unfortunately, the package build tools
	#only support installation of one currently.
	
	use gtk	\
		&& myconf="--with-gtk"	\
		|| myconf="--with-motif --without-gtk"

	
	#Build static library too, shared library is enabled by default.
	#Enable useful config options that don't have USE flags
	myconf="${myconf} --enable-static --with-zlib --with-unicode"
	
	#Note: pcx image support enabled by default if found.
	#Also, all wxWindows gui features are enabled by default. If you
	#want to build a smaller library you can disable features by adding
	#the appropriate flags to myconf (see INSTALL.txt).

	#The build tools include a --with-freetype option, however it doesn't
	#seem to be implemented in the source yet.
	
	#confiure options that have corresponding USE variable.
	
	use odbc 	\
		&& myconf="${myconf} --with-odbc"	\
		|| myconf="${myconf} --without-odbc"

	use opengl 	\
		&& myconf="${myconf} --with-opengl"	\
		|| myconf="${myconf} --without-opengl"

	use gif 	\
		&& myconf="${myconf} --enable-gif"	\
		|| myconf="${myconf} --disable-gif"

	use png 	\
		&& myconf="${myconf} --with-libpng --enable-pnm"	\
		|| myconf="${myconf} --without-libpng --disable-pnm"
	
	use jpeg	\
		&& myconf="${myconf} --with-libjpeg"	\
		|| myconf="${myconf} --without-libjpeg"

	use tiff	\
		&& myconf="${myconf} --with-libtiff"	\
		|| myconf="${myconf} --without-libtiff"
	
	gunzip < ${FILESDIR}/${P}.diff.gz | patch -p1
	
	econf ${myconf} || die "configuration failed"
	
	make || die "make failed"

}

src_install () {
	
	make 	\
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		prefix=${D}/usr \
		install || die

	dodoc *.txt
}

