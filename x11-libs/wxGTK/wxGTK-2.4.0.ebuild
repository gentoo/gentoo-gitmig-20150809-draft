# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxGTK/wxGTK-2.4.0.ebuild,v 1.8 2003/02/13 17:03:42 vapier Exp $

DESCRIPTION="GTK+ version of wxWindows, a cross-platform C++ GUI toolkit."
SRC_URI="mirror://sourceforge/wxwindows/${P}.tar.bz2"
HOMEPAGE="http://www.wxwindows.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="nls odbc opengl gtk gtk2"

DEPEND="virtual/glibc
	virtual/x11
	media-libs/netpbm
	media-libs/giflib
	media-libs/libpng
	media-libs/jpeg
	media-libs/tiff
	sys-libs/zlib
	odbc? ( dev-db/unixODBC  )
	opengl? ( virtual/opengl )
	gtk? ( =x11-libs/gtk+-1.2* )
	gtk2? ( >=x11-libs/gtk+-2.0* dev-libs/libunicode )"
RDEPEND="nls? ( sys-devel/gettext )"

pkg_setup() {
	# xfree should not install these, remove until the fixed
	# xfree is in main use.
	rm -f /usr/X11R6/include/{zconf.h,zlib.h}
}

src_compile() {
	local myconf
	myconf="--enable-gif --with-libtiff --with-zlib --with-libpng \
		--enable-png --with-libjpeg"

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

	if [ `use odbc` ] && [ ! `use gtk2` ]; then
		myconf="${myconf} --with-odbc"
	elif [ `use odbc` ] && [ `use gtk2` ]; then
		ewarn ""
		einfo "you cannot specify both odbc and gtk2"
		einfo "Choosing gtk2 over odbc"
		einfo "re-run with USE=\"-gtk2\" to enable odbc"
		ewarn ""
		sleep 5
		myconf="${myconf} --without-odbc"
	else
		myconf="${myconf} --without-odbc"
	fi

	use opengl \
		&& myconf="${myconf} --with-opengl" \
		|| myconf="${myconf} --without-opengl"

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
	use gtk2 && myconf="${myconf} --enable-gtk2 --enable-unicode"

	econf ${myconf}
	emake || die "make failed"
}

src_install() {
	einstall
	dodoc *.txt
}
