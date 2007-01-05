# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxpython/wxpython-2.4.2.4-r3.ebuild,v 1.3 2007/01/05 22:12:48 dirtyepic Exp $

inherit eutils wxwidgets python multilib

MY_P="${P/wxpython-/wxPythonSrc-}"
S="${WORKDIR}/${MY_P}/wxPython"
DESCRIPTION="A blending of the wxWindows C++ class library with Python"
HOMEPAGE="http://www.wxpython.org/"
SRC_URI="mirror://sourceforge/wxpython/${MY_P}.tar.gz"

LICENSE="wxWinLL-3"
SLOT="2.4"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="gtk gtk2 unicode opengl tiff jpeg png"

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
	if use unicode; then
		! use gtk2 && die "You must put gtk2 in your USE if you need unicode support"
	fi
}

src_compile() {
	local mypyconf

	if ! use gtk2; then
		need-wxwidgets gtk || die "Emerge wxGTK with wxgtk1 in USE"
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
	local site_pkgs=/usr/$(get_libdir)/python${PYVER}/site-packages

	use opengl \
		&& mypyconf="${mypyconf} BUILD_GLCANVAS=1" \
		|| mypyconf="${mypyconf} BUILD_GLCANVAS=0"
	use gtk2 \
		&& mypyconf="${mypyconf} WXPORT=gtk2" \
		|| mypyconf="${mypyconf} WXPORT=gtk"
	use unicode && mypyconf="${mypyconf} UNICODE=1"


	# This can all be removed when 2.4.3 is released:
	# Future: Make sure we don't clobber existing wxversion.py or wx.pth
	# from SLOT'd versions.
	if use unicode; then
		wx_name=wx-${PV:0:3}-gtk2-unicode
	elif use gtk2; then
		wx_name=wx-${PV:0:3}-gtk2-ansi
	else
		wx_name=wx-${PV:0:3}-gtk-ansi
	fi
	dest=${site_pkgs}/${wx_name}
	dodir ${site_pkgs}
	dodir ${dest}

	python setup.py ${mypyconf} install --prefix=/usr \
	--install-lib=${dest} --root=${D} || die

	echo ${wx_name} > ${D}/${site_pkgs}/wx.pth || \
		die "Couldn't create wx.pth"
	elog "Setting ${wx_name} as system default wxPython"
	echo ${wx_name} > ${D}/${site_pkgs}/wx.pth || \
		die "Couldn't create wx.pth"

	cp ${FILESDIR}/wxversion.py ${D}/${site_pkgs} || \
		die "Couldn't copy wxversion.py"
	dodir ${site_pkgs}

	cp ${FILESDIR}/wxpy-config.py ${D}/${site_pkgs}/ || \
		die "Couldn't copy wxpy-config.py"
}

pkg_postinst() {

	elog "Gentoo now uses the Multi-version method for SLOT'ing"
	elog "Developers see this site for instructions on using 2.4 or 2.6"
	elog "with your apps:"
	elog "http://wiki.wxpython.org/index.cgi/MultiVersionInstalls"
}

pkg_postrm() {
	python_version
	site_pkgs=/usr/$(get_libdir)/python${PYVER}/site-packages
	cd ${site_pkgs}
	#If 2.4 is removed, set 2.6 as default version:
	for wxver in "wx-2.6-gtk2-unicode" "wx-2.6-gtk2-ansi" "wx-2.6-gtk"
	do
		if [ -e "${wxver}" ]; then
			echo "Setting ${wxver} as system default."
			echo "${wxver}" > "wx.pth"
		fi
	done
}
