# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxGTK/wxGTK-2.4.2.ebuild,v 1.17 2004/07/22 18:04:50 pythonhead Exp $

inherit eutils

DESCRIPTION="GTK+ version of wxWidgets, a cross-platform C++ GUI toolkit."
HOMEPAGE="http://www.wxwidgets.org/"
SRC_URI="mirror://sourceforge/wxwindows/${P}.tar.bz2"

LICENSE="wxWinLL-3"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha arm amd64 ia64"
IUSE="debug gtk2 odbc opengl unicode"

RDEPEND="virtual/x11
	sys-libs/zlib
	media-libs/libpng
	media-libs/jpeg
	media-libs/tiff
	!unicode? ( odbc? ( dev-db/unixODBC ) )
	opengl? ( virtual/opengl )
	gtk2? ( >=x11-libs/gtk+-2.0 >=dev-libs/glib-2.0 )
	!gtk2? ( =x11-libs/gtk+-1.2* =dev-libs/glib-1.2* )"
DEPEND="${RDEPEND}
	gtk2? ( dev-util/pkgconfig )"

# Note 1: Gettext is not runtime dependency even if nls? because wxWidgets
#         has its own implementation of it
# Note 2: We disable unicode support because otherwise it breaks with
#         some poorly implemented wxWidgets apps like xmule and lmule.
# Note 3: PCX support is enabled if the correct libraries are detected.
#         There is no USE flag for this.

src_unpack() {
	unpack ${A}
	# fix xml contrib makefile problems
	EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-2.4.1-contrib.patch
	# disable contrib/src/animate
	EPATCH_OPTS="-d ${S}/contrib/src" epatch ${FILESDIR}/${PN}-2.4.2-contrib_animate.patch
	use amd64 && EPATCH_OPTS="-d ${S}" epatch ${FILESDIR}/${PN}-2.4.2-cleanup.patch
}

src_compile() {
	local myconf

	export LANG='C'

	myconf="${myconf} `use_with opengl`"
	myconf="${myconf} --with-gtk"
	myconf="${myconf} `use_enable debug`"

	# here we disable unicode support even thought gtk2 supports it
	# because too many apps just don't follow the wxWidgets guidelines
	# for unicode support.
	#
	# http://www.wxwidgets.org/manuals/2.4.0/wx458.htm#unicode
	#
	# bug #20116 - liquidx@gentoo.org (07 May 2003)

	use gtk2 && myconf="${myconf} --enable-gtk2"
	# only allow unicode if using gtk2
	use gtk2 && use unicode && myconf="${myconf} --enable-unicode"
	# only enable odbc if unicode is not enabled.
	! use gtk2 && ! use unicode && myconf="${myconf} `use_with odbc`"

	econf ${myconf} || die "econf failed"
	emake || die "make failed"

	cd ${S}/contrib/src
	emake || die "make contrib failed"
}

src_install() {
	einstall || die "install failed"
	dodoc *.txt

	cd ${S}/contrib/src
	einstall || die "install contrib failed"
}
