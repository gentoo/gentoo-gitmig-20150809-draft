# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxGTK/wxGTK-2.5.1-r1.ebuild,v 1.2 2004/11/06 17:30:01 pythonhead Exp $

inherit flag-o-matic eutils

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit."
HOMEPAGE="http://www.wxwidgets.org/"
SRC_URI="mirror://sourceforge/wxwindows/${P}.tar.bz2"

LICENSE="wxWinLL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug no_wxgtk1 gtk2 odbc opengl unicode"

RDEPEND="virtual/x11
	sys-libs/zlib
	media-libs/libpng
	media-libs/jpeg
	media-libs/tiff
	!unicode? ( odbc? ( dev-db/unixODBC ) )
	opengl? ( virtual/opengl )
	gtk2? ( >=x11-libs/gtk+-2.0 >=dev-libs/glib-2.0 )
	!no_wxgtk1? ( =x11-libs/gtk+-1.2* =dev-libs/glib-1.2* )"
DEPEND="${RDEPEND}
	gtk2? ( dev-util/pkgconfig )"

# Note 1: Gettext is not runtime dependency even if nls? because wxWidgets
#         has its own implementation of it
# Note 2: PCX support is enabled if the correct libraries are detected.
#         There is no USE flag for this.

pkg_setup() {
	einfo "New in >=wxGTK-2.4.2-r2:"
	einfo "------------------------"
	einfo "You can now have gtk, gtk2 and unicode versions installed"
	einfo "simultaneously. gtk is installed by default because it is"
	einfo "more stable than gtk2. Use no_wxgtk1 if you don't want it."
	einfo "Put gtk2 and unicode in your USE flags to get those"
	einfo "additional versions."
	einfo "NOTE:"
	einfo "You can also get debug versions of any of those, but not debug"
	einfo "and normal installed at the same time."
	if  use unicode; then
		! use gtk2 && die "You must put gtk2 in your USE if you need unicode support"
	fi
	if use no_wxgtk1 && ! use gtk2; then
		die "You must have at least gtk2 or -no_wxgtk1 in your USE"
	fi
}

src_compile() {
	local myconf
	export LANG='C'
	filter-flags -fvisibility-inlines-hidden
	myconf="${myconf} `use_with opengl`"
	myconf="${myconf} --with-gtk"
	myconf="${myconf} `use_enable debug`"
	#For apps like net-p2p/amule that use obsolete wxDate/wxTime
	myconf="${myconf} --enable-timedate"

	if ! use no_wxgtk1 ; then
		mkdir build_gtk
		einfo "Building gtk version"
		cd build_gtk
		../configure ${myconf} `use_with odbc`\
			--host=${CHOST} \
			--prefix=/usr \
			--infodir=/usr/share/info \
			--mandir=/usr/share/man || die "./configure failed"
		emake || die "make gtk failed"
		cd contrib/src
		emake || die "make gtk contrib failed"
	fi
	cd ${S}

	if use gtk2 ; then
		myconf="${myconf} --enable-gtk2"
		einfo "Building gtk2 version"
		mkdir build_gtk2
		cd build_gtk2
		../configure ${myconf} \
			--host=${CHOST} \
			--prefix=/usr \
			--infodir=/usr/share/info \
			--mandir=/usr/share/man || die "./configure failed"
		emake || die "make gtk2 failed"
		cd contrib/src
		emake || die "make gtk2 contrib failed"

		cd ${S}

		if use unicode ; then
			myconf="${myconf} --enable-unicode"
			einfo "Building unicode version"
			mkdir build_unicode
			cd build_unicode
			../configure ${myconf} \
				--host=${CHOST} \
				--prefix=/usr \
				--infodir=/usr/share/info \
				--mandir=/usr/share/man || die "./configure failed"

			emake || die "make unicode failed"

			cd contrib/src
			emake || die "make unicode contrib failed"
		fi
	fi
}

src_install() {
	if [ -e ${S}/build_gtk ] ; then
		cd ${S}/build_gtk
		einstall || die "install gtk failed"
		cd contrib/src
		einstall || die "install gtk contrib failed"
	fi

	if [ -e ${S}/build_unicode ] ; then
		cd ${S}/build_unicode
		einstall || die "install unicode failed"
		cd contrib/src
		einstall || die "install unicode contrib failed"
	fi

	if [ -e ${S}/build_gtk2 ] ; then
		cd ${S}/build_gtk2
		einstall || die "install gtk2 failed"
		cd contrib/src
		einstall || die "install gtk2 contrib failed"
	fi

	# twp 20040830 wxGTK forgets to install htmlproc.h; copy it manually
	insinto /usr/include/wx/html
	doins ${S}/include/wx/html/htmlproc.h

	cd ${S}
	dodoc *.txt
}
