# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxpython/wxpython-2.5.3.1.ebuild,v 1.1 2004/11/13 04:08:20 pythonhead Exp $

inherit wxwidgets

MY_P="${P/wxpython-/wxPython-src-}"
S="${WORKDIR}/${MY_P}/wxPython"
DESCRIPTION="A blending of the wxWindows C++ class library with Python"
HOMEPAGE="http://www.wxpython.org/"
SRC_URI="mirror://sourceforge/wxpython/${MY_P}.tar.gz"

LICENSE="wxWinLL-3"
SLOT="2.5"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~amd64 ~ia64 ~hppa"
IUSE="gtk2 unicode opengl tiff jpeg png"

RDEPEND=">=dev-lang/python-2.1
	=x11-libs/wxGTK-2.5.3*
	!<dev-python/wxpython-2.4.2.4-r1
	gtk2? ( >=x11-libs/gtk+-2.0
		>=x11-libs/pango-1.2
		>=dev-libs/glib-2.0 )
	unicode? ( >=x11-libs/gtk+-2.0
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
	gtk2? ( dev-util/pkgconfig )
	sys-apps/sed"

pkg_setup() {
	einfo "You can now have gtk, gtk2 and unicode versions of wxGTK"
	einfo "simultaneously installed as of >=wxGTK-2.4.2-r2."
	einfo "This means you can have wxpython installed using any one of those"
	einfo "versions by setting gtk2, unicode, or -gtk2 (for gtk1) in USE"
	if  use unicode; then
		! use gtk2 && die "You must put gtk2 in your USE if you need unicode support"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:cflags.append('-O3'):pass:" config.py || die
}

src_compile() {
	local mypyconf
	export WX_GTK_VER="2.5"
	if ! use gtk2; then
		need-wxwidgets gtk || die "Emerge wxGTK with -no_wxgtk1 in USE"
	elif use unicode; then
		need-wxwidgets unicode || die "Emerge wxGTK with unicode in USE"
	else
		need-wxwidgets gtk2 || die "Emerge wxGTK with gtk2 in USE"
	fi
	mypyconf="${mypyconf} WX_CONFIG=${WX_CONFIG}"
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
	python_version
	local mypyconf
	local site_pkgs=/usr/lib/python${PYVER}/site-packages

	use opengl \
		&& mypyconf="${mypyconf} BUILD_GLCANVAS=1" \
		|| mypyconf="${mypyconf} BUILD_GLCANVAS=0"

	use gtk2 \
		&& mypyconf="${mypyconf} WXPORT=gtk2" \
		|| mypyconf="${mypyconf} WXPORT=gtk"

	use unicode && mypyconf="${mypyconf} UNICODE=1"

	python setup.py ${mypyconf} install --prefix=/usr --root=${D} || die

	# Don't clobber existing versions from SLOT'd version
	if [ -e "${site_pkgs}/wxversion.py" ]; then
		rm ${D}/${site_pkgs}/wxversion.py
	fi
	if [ -e "${site_pkgs}/wx.pth" ]; then
		rm ${D}/${site_pkgs}/wx.pth
	fi
	if [ ! -e "${site_pkgs}/wxpy-config.py" ]; then
		cp ${FILESDIR}/wxpy-config.py ${D}/${site_pkgs}/ || \
			die "Couldn't copy wxpy-config.py"
	fi
}

