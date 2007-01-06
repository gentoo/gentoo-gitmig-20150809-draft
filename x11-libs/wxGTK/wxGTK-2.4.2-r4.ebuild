# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxGTK/wxGTK-2.4.2-r4.ebuild,v 1.10 2007/01/06 02:11:30 dirtyepic Exp $

inherit flag-o-matic eutils multilib toolchain-funcs

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit"
HOMEPAGE="http://www.wxwidgets.org/"
SRC_URI="mirror://sourceforge/wxwindows/${P}.tar.bz2"

LICENSE="wxWinLL-3"
SLOT="2.4"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="debug wxgtk1 gtk odbc opengl unicode"

RDEPEND="sys-libs/zlib
	media-libs/libpng
	media-libs/jpeg
	media-libs/tiff
	!unicode? ( odbc? ( dev-db/unixODBC ) )
	opengl? ( virtual/opengl )
	gtk? ( >=x11-libs/gtk+-2.0 >=dev-libs/glib-2.0 )
	wxgtk1? ( =x11-libs/gtk+-1.2* =dev-libs/glib-1.2* )"
DEPEND="${RDEPEND}
	gtk? ( dev-util/pkgconfig )"

# Note 1: Gettext is not runtime dependency even if nls? because wxWidgets
#         has its own implementation of it
# Note 2: PCX support is enabled if the correct libraries are detected.
#         There is no USE flag for this.

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PN}-2.4.2-menu.cpp.patch || \
		die "Failed to patch menu.cpp"
	# fix xml contrib makefile problems
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-2.4.1-contrib.patch

	# fix pango_x_get_context stuff
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-2.4.2-pango_fix.patch

	# disable contrib/src/animate
	EPATCH_OPTS="-d ${S}/contrib/src" epatch ${FILESDIR}/${PN}-2.4.2-contrib_animate.patch
	use amd64 && EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-2.4.2-cleanup.patch

	# gcc 4 compile patch ; bug #117357
	epatch "${FILESDIR}"/${P}-gcc4.patch

	# freetype-2.2.1 compile patch #150383
	if has_version '>=media-libs/freetype-2.2.1'; then
		epatch ${FILESDIR}/${PN}-2.4.2-noftinternals.patch
	fi
}

pkg_setup() {
	elog "New in >=wxGTK-2.4.2-r2:"
	elog "------------------------"
	elog "You can now have gtk1, gtk2 and unicode versions installed"
	elog "simultaneously. Use wxgtk1 if you would like a gtk1 lib."
	elog "Put gtk and unicode in your USE flags to get those"
	elog "additional versions."
	elog "NOTE:"
	elog "You can also get debug versions of any of those, but not debug"
	elog "and normal installed at the same time."
	if  use unicode; then
		! use gtk && die "You must put gtk in your USE if you need unicode support"
	fi
	if ! use wxgtk1 && ! use gtk; then
		die "You must have at least gtk or wxgtk1 in your USE"
	fi
}

src_compile() {
	local myconf
	export LANG='C'
	filter-flags -fvisibility-inlines-hidden
	myconf="${myconf} `use_with opengl`"
	myconf="${myconf} --with-gtk"
	myconf="${myconf} `use_enable debug`"
	myconf="${myconf} --libdir=/usr/$(get_libdir)"
	myconf="${myconf} `use_with odbc`"

	if use wxgtk1 ; then
		mkdir build_gtk
		elog "Building gtk version"
		cd build_gtk
		ECONF_SOURCE=".." econf ${myconf} || die "econf gtk1 failed"
		emake CXX="$(tc-getCXX)" CC="$(tc-getCC)" || die "emake gtk1 failed"
		cd contrib/src
		emake CXX="$(tc-getCXX)" CC="$(tc-getCC)" || die "emake gtk1 contrib failed"
	fi

	cd ${S}

	if use gtk ; then
		myconf="${myconf} --enable-gtk2"
		elog "Building gtk2 version"
		mkdir build_gtk2
		cd build_gtk2
		ECONF_SOURCE=".." econf ${myconf} || die "econf gtk2 failed"
		emake CXX="$(tc-getCXX)" CC="$(tc-getCC)" || die "emake gtk2 failed"
		cd contrib/src
		emake CXX="$(tc-getCXX)" CC="$(tc-getCC)" || die "emake gtk2 contrib failed"

		cd ${S}

		if use unicode ; then
			myconf="${myconf} --enable-unicode"
			elog "Building unicode version"
			mkdir build_unicode
			cd build_unicode
			ECONF_SOURCE=".." econf ${myconf} || die "econf unicode failed"
			emake CXX="$(tc-getCXX)" CC="$(tc-getCC)" || die "emake unicode failed"
			cd contrib/src
			emake CXX="$(tc-getCXX)" CC="$(tc-getCC)" || die "emake unicode contrib failed"
		fi
	fi
}

src_install() {
	if [ -e ${S}/build_gtk ] ; then
		cd ${S}/build_gtk
		einstall libdir="${D}/usr/$(get_libdir)" || die "install gtk failed"
		cd contrib/src
		einstall libdir="${D}/usr/$(get_libdir)" || die "install gtk contrib failed"
	fi

	if [ -e ${S}/build_gtk2 ] ; then
		cd ${S}/build_gtk2
		einstall libdir="${D}/usr/$(get_libdir)" || die "install gtk2 failed"
		cd contrib/src
		einstall libdir="${D}/usr/$(get_libdir)" || die "install gtk2 contrib failed"
	fi

	if [ -e ${S}/build_unicode ] ; then
		cd ${S}/build_unicode
		einstall libdir="${D}/usr/$(get_libdir)" || die "install unicode failed"
		cd contrib/src
		einstall libdir="${D}/usr/$(get_libdir)" || die "install unicode contrib failed"
	fi

	# twp 20040830 wxGTK-2.4.2 forgets to install htmlproc.h; copy it manually
	insinto /usr/include/wx/html
	doins ${S}/include/wx/html/htmlproc.h

	cd ${S}
	dodoc *.txt
}
