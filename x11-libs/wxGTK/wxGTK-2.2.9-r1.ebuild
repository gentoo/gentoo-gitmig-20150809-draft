# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxGTK/wxGTK-2.2.9-r1.ebuild,v 1.2 2002/08/23 00:23:16 raker Exp $


S=${WORKDIR}/${P}

DESCRIPTION="GTK+ version of wxWindows, a cross-platform C++ GUI toolkit."

SRC_URI="mirror://sourceforge/wxwindows/${P}.tar.bz2"

HOMEPAGE="http://www.wxwindows.org/"

LICENSE="GPL"

SLOT="0"

DEPEND="=x11-libs/gtk+-1.2*
	dev-libs/libunicode
	media-libs/libpng
	media-libs/jpeg
	media-libs/tiff
	media-libs/netpbm
	nls? ( sys-devel/gettext )
	odbc? ( dev-db/unixODBC  )
	gif? ( media-libs/giflib )
	opengl? ( virtual/opengl )"
	
#Possible future dependancies
#	motif? ( x11-libs/openmotif )
#	ungif? ( media-libs/libungif )

RDEPEND="${DEPEND}"

KEYWORDS="x86 -ppc -sparc -sparc64"

src_compile() {

	
	#cp configure.in configure.in.orig
	#sed '1610i\    /usr/include/freetype2 \\' configure.in.orig > configure.in
		

	local myconf
	#--with-gtk enabled by default, if you want to build against motif,
	#replace --with-gtk with --with-motif and --without-gtk. You will
	#also need openmotif installed.	Unfortunately, the package build tools
	#only support installation of one currently.
	
	myconf="--with-gtk"
	
	#Build static library too, shared library is enabled by default.
	#Enable useful config options that don't have USE flags
	myconf="$myconf --enable-static --with-zlib --with-unicode"
	
	#Note: png,jpeg,tiff,pnm, and pcx image support enabled by default if found.
	#Also, all wxWindows gui features are enabled by default. If you
	#want to build a smaller library you can disable features by adding
	#the appropriate flags to myconf (see INSTALL.txt).

	#The build tools include a --with-freetype option, however it doesn't
	#seem to be implemented in the source yet.
	
	#configure options that have corresponding USE variable.
	
	use odbc && myconf="$myconf --with-odbc" #disabled by default
	use gif  || myconf="$myconf --disable-gif" #enabled by default
	use opengl && myconf="$myconf --with-opengl" #disabled by default
   	
	#apply the patch to get compiled with GCC-3.1
	gunzip < ${FILESDIR}/${P}.diff.gz | patch -p1

	CFLAGS="${CFLAGS} -DZEXPORT=''"
	CXXFLAGS="${CXXFLAGS} -DZEXPORT=''"

	econf ${myconf} || die "configuration failed"
	
	make || die "compilation failed"

}

src_install () {
	
	einstall || die "installation failed"

	dodoc  CHANGES.txt COPYING.LIB INSTALL.txt \
		LICENCE.txt README.txt SYMBOLS.txt TODO.txt
		
}

