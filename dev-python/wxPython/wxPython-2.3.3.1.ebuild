# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxPython/wxPython-2.3.3.1.ebuild,v 1.1 2002/10/29 07:11:10 vapier Exp $

IUSE="nls odbc jpeg png opengl gif tiff zlib X"

MY_P="${P/-/Src-}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="A blending of the wxWindows C++ class library with Python."
SRC_URI="mirror://sourceforge/wxpython/${MY_P}.tar.gz"
HOMEPAGE="http://www.wxpython.org/"

DEPEND="dev-libs/libunicode
	media-libs/netpbm
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )
	zlib? ( sys-libs/zlib )
	odbc? ( dev-db/unixODBC  )
	opengl? ( virtual/opengl >=dev-python/PyOpenGL-2.0.0.44 )
	X? ( virtual/x11 )
	>=dev-lang/python-2.1
	=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	=x11-libs/wxGTK-2.3.3*"
RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"

pkg_setup() {
	# xfree should not install these, remove until the fixed
	# xfree is in main use.
	rm -f /usr/X11R6/include/{zconf.h,zlib.h}
}

src_compile() {
	local myconf=""

	local myconf

	#Note: pcx image support enabled by default if found.
	#Also, all wxWindows gui features are enabled by default. If you
	#want to build a smaller library you can disable features by adding
	#the appropriate flags to myconf (see INSTALL.txt).

	#The build tools include a --with-freetype option, however it doesn't
	#seem to be implemented in the source yet.
	
	#confiure options that have corresponding USE variable.

	use static \
		&& myconf="${myconf} --enable-static" \
		|| myconf="${myconf} --disable-static"

	use nls \
		&& myconf="${myconf} --with-unicode" \
		|| myconf="${myconf} --without-unicode"

	use gif \
		&& myconf="${myconf} --enable-gif" \
		|| myconf="${myconf} --disable-gif"

	use tiff \
		&& myconf="${myconf} --with-libtiff" \
		|| myconf="${myconf} --without-libtiff"

	use zlib \
		&& myconf="${myconf} --with-zlib" \
		|| myconf="${myconf} --without-zlib"

	use odbc \
		&& myconf="${myconf} --with-odbc" \
		|| myconf="${myconf} --without-odbc"

	use opengl \
		&& myconf="${myconf} --with-opengl" \
		|| myconf="${myconf} --without-opengl"

	use png \
		&& myconf="${myconf} --with-libpng --enable-png" \
		|| myconf="${myconf} --without-libpng --disable-png"
	
	use jpeg \
		&& myconf="${myconf} --with-libjpeg" \
		|| myconf="${myconf} --without-libjpeg"

	use X && myconf="${myconf} --with-x"

	# here we specify our own preference of which toolkit to build ...
	# but only gtk seems to work atm ...
#	if [ `use gtk` ] ; then
		myconf="${myconf} --with-gtk"
#	elif [ `use X` ] ; then
#		myconf="${myconf} --with-x11"
#	elif [ `use motif` ] ; then
#		myconf="${myconf} --with-motif"
#	else
#		eerror "You must have either gtk, X, or motif in your USE variable"
#		die "could not specify toolkit"
#	fi
#	use gtk2 && myconf="${myconf} --enable-gtk2"

	ln -s ${S}/contrib/ ${S}/wxPython/contrib/ogl/contrib

	econf ${myconf}
	make || die
}

src_install() {
	einstall
}
