# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxpython/wxpython-2.6.1.0.ebuild,v 1.11 2007/01/05 22:12:48 dirtyepic Exp $

inherit python wxwidgets eutils multilib

MY_P="${P/wxpython-/wxPython-src-}"
DESCRIPTION="A blending of the wxWindows C++ class library with Python"
HOMEPAGE="http://www.wxpython.org/"
SRC_URI="mirror://sourceforge/wxpython/${MY_P}.tar.gz"

LICENSE="wxWinLL-3"
SLOT="2.6"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="gtk gtk2 unicode opengl"

RDEPEND=">=dev-lang/python-2.1
	=x11-libs/wxGTK-2.6*
	!<dev-python/wxpython-2.4.2.4-r1
	gtk2? ( >=x11-libs/gtk+-2.0
		>=x11-libs/pango-1.2
		>=dev-libs/glib-2.0 )
	unicode? ( >=x11-libs/gtk+-2.0
		>=x11-libs/pango-1.2
		>=dev-libs/glib-2.0 )
	!gtk2? ( =x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2* )
	media-libs/libpng
	media-libs/jpeg
	media-libs/tiff
	>=sys-libs/zlib-1.1.4
	opengl? ( >=dev-python/pyopengl-2.0.0.44 )
	!<dev-python/wxpython-2.4.2.4-r1"

DEPEND="${RDEPEND}
	gtk2? ( dev-util/pkgconfig )
	sys-apps/sed"

S="${WORKDIR}/${MY_P}/wxPython/"

pkg_setup() {
	if  use unicode; then
		! use gtk2 && die "You must put gtk2 in your USE if you need unicode support"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S} || die "failed to cd to ${S}"
	sed -i "s:cflags.append('-O3'):pass:" config.py || die "sed failed"
	epatch ${FILESDIR}/scripts-multiver-${PV}.diff
}

src_compile() {
	local mypyconf
	export WX_GTK_VER="2.6"
	if ! use gtk2; then
		need-wxwidgets gtk
	elif use unicode; then
		need-wxwidgets unicode
	else
		need-wxwidgets gtk2
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
	local site_pkgs=/usr/$(get_libdir)/python${PYVER}/site-packages
	dodir ${site_pkgs}

	if ! use gtk2; then
		need-wxwidgets gtk || die "Emerge wxGTK with wxgtk1 in USE"
	elif use unicode; then
		need-wxwidgets unicode || die "Emerge wxGTK with unicode in USE"
	else
		need-wxwidgets gtk2 || die "Emerge wxGTK with gtk2 in USE"
	fi

	mypyconf="${mypyconf} WX_CONFIG=${WX_CONFIG}"
	use opengl \
		&& mypyconf="${mypyconf} BUILD_GLCANVAS=1" \
		|| mypyconf="${mypyconf} BUILD_GLCANVAS=0"

	use gtk2 \
		&& mypyconf="${mypyconf} WXPORT=gtk2" \
		|| mypyconf="${mypyconf} WXPORT=gtk"

	use unicode && mypyconf="${mypyconf} UNICODE=1"

	python setup.py ${mypyconf} install --prefix=/usr --root=${D} || die

	if [ -e "${site_pkgs}/wx.pth" ] && [ "`grep -o 2.4 ${site_pkgs}/wx.pth`" = "2.4" ]; then
		rm ${D}/${site_pkgs}/wx.pth
		elog "Keeping 2.4 as system default wxPython"
	else
		if use unicode; then
			wx_name=wx-${PV:0:3}-gtk2-unicode
		elif use gtk2; then
			wx_name=wx-${PV:0:3}-gtk2-ansi
		else
			wx_name=wx-${PV:0:3}-gtk-ansi
		fi

		elog "Setting ${wx_name} as system default wxPython"
		echo ${wx_name} > ${D}/${site_pkgs}/wx.pth || \
			die "Couldn't create wx.pth"

	fi

	cp ${FILESDIR}/wxpy-config.py ${D}/${site_pkgs}/

	#Add ${PV} suffix to all /usr/bin/* programs to avoid clobbering SLOT'd
	for filename in ${D}/usr/bin/* ; do
		mv ${filename} ${filename}-2.6
	done
}

pkg_postinst() {

	elog "Gentoo now uses the Multi-version method for SLOT'ing"
	elog "Developers see this site for instructions on using 2.4 or 2.6"
	elog "with your apps:"
	elog "http://wiki.wxpython.org/index.cgi/MultiVersionInstalls"
}
