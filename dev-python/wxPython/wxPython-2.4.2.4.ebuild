# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxPython/wxPython-2.4.2.4.ebuild,v 1.9 2004/02/17 22:02:26 agriffis Exp $

inherit eutils

IUSE="opengl tiff jpeg png gtk2 unicode"

MY_P="${P/-/Src-}"
S="${WORKDIR}/${MY_P}/${PN}"
DESCRIPTION="A blending of the wxWindows C++ class library with Python."
SRC_URI="mirror://sourceforge/wxpython/${MY_P}.tar.gz"
HOMEPAGE="http://www.wxpython.org/"

SLOT="0"
LICENSE="wxWinLL-3"
KEYWORDS="~x86 ppc ~sparc alpha ~amd64 ia64"

RDEPEND=">=dev-lang/python-2.1
	>=x11-libs/wxGTK-2.4.2
	gtk2? ( >=x11-libs/gtk+-2.0
		>=x11-libs/pango-1.2
		>=dev-libs/glib-2.0 )
	!gtk2? ( =x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2* )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )
	>=sys-libs/zlib-1.1.4
	opengl? ( >=dev-python/PyOpenGL-2.0.0.44 )"

DEPEND="${RDEPEND}
	gtk2? ( dev-util/pkgconfig )"

pkg_setup() {
	# make sure if you want gtk2, you have wxGTK with gtk2, and vice versa
	if [ -n "`use gtk2`" ]; then
		if [ ! -f "/usr/bin/wxgtk2u-2.4-config" -a ! -f "/usr/bin/wxgtk2ud-2.4-config" -a ! -f "/usr/bin/wxgtk2-2.4-config" -a ! -f "/usr/bin/wxgtk2d-2.4-config" ]; then
			eerror "You need x11-libs/wxGTK compiled with GTK+2 support."
			eerror "Either emerge wxGTK with 'gtk2' in your USE flags or"
			eerror "emerge wxPython without 'gtk2' in your USE flags."
			die "wxGTK needs to be compiled with gtk2"
		fi
	else
		if [ ! -f "/usr/bin/wxgtk-2.4-config" ]; then
			eerror "You need x11-libs/wxGTK compiled with GTK+1."
			eerror "Either emerge wxGTK without 'gtk2' in your USE flags or"
			eerror "emerge wxPython with 'gtk2' in your USE flags."
			die "wxGTK needs to be compiled without gtk2"
		fi
	fi

	# make sure that wxPython and wxGTK have same unicode setting:
	if [ -n "`use unicode`" ]; then
		if [ ! -f "/usr/bin/wxgtk2u-2.4-config" -a ! -f "/usr/bin/wxgtk2ud-2.4-config" ]; then
			eerror "You need x11-libs/wxGTK compiled with Unicode support."
			eerror "Either emerge wxGTK with 'unicode' in your USE flags or"
			eerror "emerge wxPython without 'unicode' in your USE flags."
			die "wxGTK needs to be compiled with unicode"
		fi
	else
		if [ ! -f "/usr/bin/wxgtk-2.4-config" -a ! -f "/usr/bin/wxgtk2-2.4-config" -a ! -f "/usr/bin/wxgtkd-2.4-config" -a ! -f "/usr/bin/wxgtk2d-2.4-config" ]; then
			eerror "You need x11-libs/wxGTK compiled without Unicode."
			eerror "Either emerge wxGTK without 'unicode' in your USE flags or"
			eerror "emerge wxPython with 'unicode' in your USE flags."
			die "wxGTK needs to be compiled without unicode"
		fi
	fi

}

src_compile() {
	local mypyconf

	use opengl \
		&& 	mypyconf="${mypyconf} BUILD_GLCANVAS=1" \
		|| mypyconf="${mypyconf} BUILD_GLCANVAS=0"

	use gtk2 \
		&&	mypyconf="${mypyconf} WXPORT=gtk2" \
		|| mypyconf="${mypyconf} WXPORT=gtk"

	use unicode && mypyconf="${mypyconf} UNICODE=1"

	python setup.py ${mypyconf} build || die "build failed"
}

src_install() {
	local mypyconf

	use opengl \
		&& mypyconf="${mypyconf} BUILD_GLCANVAS=1" \
		|| mypyconf="${mypyconf} BUILD_GLCANVAS=0"

	use gtk2 \
		&& mypyconf="${mypyconf} WXPORT=gtk2" \
		|| mypyconf="${mypyconf} WXPORT=gtk"

	use unicode && mypyconf="${mypyconf} UNICODE=1"

	python setup.py ${mypyconf} install --prefix=/usr --root=${D} || die
}
