# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxpython/wxpython-2.4.2.4.ebuild,v 1.6 2004/08/02 14:47:46 fmccor Exp $

inherit eutils

MY_P="${P/wxpython-/wxPythonSrc-}"
S="${WORKDIR}/${MY_P}/wxPython"
DESCRIPTION="A blending of the wxWindows C++ class library with Python"
HOMEPAGE="http://www.wxpython.org/"
SRC_URI="mirror://sourceforge/wxpython/${MY_P}.tar.gz"

LICENSE="wxWinLL-3"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha arm amd64 ia64 hppa"
IUSE="opengl tiff jpeg png gtk2 unicode"

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
	opengl? ( >=dev-python/pyopengl-2.0.0.44 )"

DEPEND="${RDEPEND}
	gtk2? ( dev-util/pkgconfig )"

pkg_setup() {
	# make sure if you want gtk2, you have wxGTK with gtk2, and vice versa
	if use gtk2; then
		if [ ! -f "/usr/bin/wxgtk2u-2.4-config" -a ! -f "/usr/bin/wxgtk2ud-2.4-config" -a ! -f "/usr/bin/wxgtk2-2.4-config" -a ! -f "/usr/bin/wxgtk2d-2.4-config" ]; then
			eerror "You need x11-libs/wxGTK compiled with GTK+2 support."
			eerror "Either emerge wxGTK with 'gtk2' in your USE flags or"
			eerror "emerge wxpython with '-gtk2' in your USE flags."
			die "wxGTK needs to be compiled with USE='gtk2'"
		fi
	else
		if [ ! -f "/usr/bin/wxgtk-2.4-config" ]; then
			eerror "You need x11-libs/wxGTK compiled with GTK+1."
			eerror "Either re-emerge wxGTK with '-gtk2' in your USE flags or"
			eerror "emerge wxpython with '-gtk2' in your USE flags."
			die "wxGTK needs to be compiled with USE='-gtk2'"
		fi
	fi

	# make sure that wxpython and wxGTK have same unicode setting:
	if use unicode; then
		if [ ! -f "/usr/bin/wxgtk2u-2.4-config" -a ! -f "/usr/bin/wxgtk2ud-2.4-config" ]; then
			eerror "You need x11-libs/wxGTK compiled with Unicode support."
			eerror "Either emerge wxGTK with 'unicode' in your USE flags or"
			eerror "emerge wxpython without 'unicode' in your USE flags."
			die "wxGTK needs to be compiled with unicode"
		fi
	else
		if [ ! -f "/usr/bin/wxgtk-2.4-config" -a ! -f "/usr/bin/wxgtk2-2.4-config" -a ! -f "/usr/bin/wxgtkd-2.4-config" -a ! -f "/usr/bin/wxgtk2d-2.4-config" ]; then
			eerror "You need x11-libs/wxGTK compiled without Unicode."
			eerror "Either emerge wxGTK without 'unicode' in your USE flags or"
			eerror "emerge wxpython with 'unicode' in your USE flags."
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
