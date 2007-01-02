# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/wxmozilla/wxmozilla-0.5.7_pre20070102.ebuild,v 1.2 2007/01/02 21:47:53 dirtyepic Exp $

inherit eutils wxwidgets

# Currently force building against firefox.  Seamonkey is supported but
# crashes.  Upstream will fix and release as 0.5.7. bug #130969
#IUSE="doc firefox python"
IUSE="doc python"

DESCRIPTION="Mozilla widget for wxWindows"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://wxmozilla.sourceforge.net/"

#DEPEND="
#	=x11-libs/wxGTK-2.6*
#	firefox? ( >=www-client/mozilla-firefox-2.0 )
#	!firefox?	( >=www-client/seamonkey-1.0.0 )
#	python?	( dev-lang/python
#			>=dev-python/wxpython-2.6.3 )"
DEPEND="
   =x11-libs/wxGTK-2.6*
   >=www-client/mozilla-firefox-2.0
   python? ( dev-lang/python
           >=dev-python/wxpython-2.6.3 )"

SLOT="0"
LICENSE="wxWinLL-3"
KEYWORDS="~x86"

S="${WORKDIR}/wxMozilla"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {

	# Current Problems:
	#   -can't find wx-config without the funky configure option
	#   -configure will give a warning about wxpython, but it can be ignored.

	# Currently Working:
	#
	# Firefox 2.0 support.  Builds against seamonkey-1.0.7 but crashes

	WX_GTK_VER="2.6"
	need-wxwidgets unicode

	#if use firefox; then
	#	myconf="--enable-firefox --disable-seamonkey"
	#else
	#	myconf="--disable-firefox --enable-seamonkey"
	#fi
	myconf="--enable-firefox --disable-seamonkey"

	econf \
		$(use_enable python) \
		--disable-gtktest \
		--with-wx-config=wx-config-2.6 \
		${myconf} \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	if use doc; then
		dodoc README Changelog NEWS
		newdoc demo/main.cpp example.cpp
		use python && dodoc wxPython/demo/*.py
	fi
}
