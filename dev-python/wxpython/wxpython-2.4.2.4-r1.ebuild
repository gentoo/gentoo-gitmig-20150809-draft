# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxpython/wxpython-2.4.2.4-r1.ebuild,v 1.1 2004/11/13 04:08:20 pythonhead Exp $

inherit eutils wxwidgets python

MY_P="${P/wxpython-/wxPythonSrc-}"
S="${WORKDIR}/${MY_P}/wxPython"
DESCRIPTION="A blending of the wxWindows C++ class library with Python"
HOMEPAGE="http://www.wxpython.org/"
SRC_URI="mirror://sourceforge/wxpython/${MY_P}.tar.gz"

LICENSE="wxWinLL-3"
SLOT="2.4"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~amd64 ~ia64 ~hppa ~ppc64"
IUSE="gtk2 unicode opengl tiff jpeg png"

RDEPEND=">=dev-lang/python-2.1
	=x11-libs/wxGTK-2.4.2*
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
	gtk2? ( dev-util/pkgconfig )"

pkg_setup() {
	einfo "You can now have gtk, gtk2 and unicode versions of wxGTK"
	einfo "simultaneously installed as of >=wxGTK-2.4.2-r2."
	einfo "This means you can have wxpython installed using any one of those"
	einfo "versions by setting gtk2, unicode, or -gtk2 (for gtk1) in USE"
	if  use unicode; then
		! use gtk2 && die "You must put gtk2 in your USE if you need unicode support"
	fi
}

src_compile() {
	local mypyconf

	if ! use gtk2; then
		need-wxwidgets gtk || die "Emerge wxGTK with -no_wxgtk1 in USE"
	elif use unicode; then
		need-wxwidgets unicode || die "Emerge wxGTK with unicode in USE"
	else
		need-wxwidgets gtk2 || die "Emerge wxGTK with gtk2 in USE"
	fi

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
	local dest
	local wx_name
	local site_pkgs=/usr/lib/python${PYVER}/site-packages

	use opengl \
		&& mypyconf="${mypyconf} BUILD_GLCANVAS=1" \
		|| mypyconf="${mypyconf} BUILD_GLCANVAS=0"
	use gtk2 \
		&& mypyconf="${mypyconf} WXPORT=gtk2" \
		|| mypyconf="${mypyconf} WXPORT=gtk"
	use unicode && mypyconf="${mypyconf} UNICODE=1"

	python setup.py ${mypyconf} install --prefix=/usr --root=${D} || die

	# This can all be removed when 2.4.3 is released:
	# Future: Make sure we don't clobber existing wxversion.py or wx.pth
	# from SLOT'd versions.
	if use unicode; then
		wx_name=wx-${PV:0:5}-gtk2-unicode
	elif use gtk2; then
		wx_name=wx-${PV:0:5}-gtk2-ansi
	else
		wx_name=wx-${PV:0:5}-gtk-ansi
	fi
	dest=${site_pkgs}/${wx_name}
	dodir ${site_pkgs}
	dodir ${dest}
	mv ${D}/${site_pkgs}/wx ${D}/${dest}
	mv ${D}/${site_pkgs}/wxPython ${D}/${dest}
	if [ ! -e "${site_pkgs}/wx.pth" ]; then
		echo ${wx_name} > ${D}/${site_pkgs}/wx.pth || \
			die "Couldn't create wx.pth"
		einfo "Setting ${wx_name} as system default wxPython"
		echo ${wx_name} > ${D}/${site_pkgs}/wx.pth || \
			die "Couldn't create wx.pth"
	fi
	if [ ! -e "${site_pkgs}/wxversion.py" ]; then
		cp ${FILESDIR}/wxversion.py ${D}/${site_pkgs} || \
			die "Couldn't copy wxversion.py"
	fi
	if [ ! -e "${site_pkgs}/wxpy-config.py" ]; then
		cp ${FILESDIR}/wxpy-config.py ${D}/${site_pkgs}/ || \
			die "Couldn't copy wxpy-config.py"
	fi
}

