# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxpython/wxpython-2.8.9.1-r2.ebuild,v 1.3 2009/01/18 19:29:05 maekke Exp $

EAPI="2"
WX_GTK_VER="2.8"

inherit alternatives eutils multilib python wxwidgets flag-o-matic
# We don't use distutils.eclass because it doesn't seem to play nice with
# need-wxwidgets

MY_P="${P/wxpython-/wxPython-src-}"
DESCRIPTION="A blending of the wxWindows C++ class library with Python"
HOMEPAGE="http://www.wxpython.org/"
SRC_URI="mirror://sourceforge/wxpython/${MY_P}.tar.bz2"

LICENSE="wxWinLL-3"
SLOT="2.8"
KEYWORDS="alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="cairo opengl"

RDEPEND=">=x11-libs/wxGTK-${PV}:2.8[opengl?]
	>=dev-lang/python-2.4
	>=x11-libs/gtk+-2.4
	>=x11-libs/pango-1.2
	>=dev-libs/glib-2.0
	media-libs/libpng
	media-libs/jpeg
	media-libs/tiff
	cairo? ( dev-python/pycairo )
	opengl? ( >=dev-python/pyopengl-2.0.0.44 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}/wxPython/"

src_prepare() {
	sed -i "s:cflags.append('-O3'):pass:" config.py || die "sed failed"
	epatch "${FILESDIR}"/${PN}-2.8.8-wxversion-scripts.patch
}

src_configure() {
	need-wxwidgets unicode

	append-flags -fno-strict-aliasing

	use opengl \
		&& mypyconf="${mypyconf} BUILD_GLCANVAS=1" \
		|| mypyconf="${mypyconf} BUILD_GLCANVAS=0"

	mypyconf="${mypyconf} WX_CONFIG=${WX_CONFIG}"
	mypyconf="${mypyconf} WXPORT=gtk2 UNICODE=1"
}

src_compile() {
	python setup.py ${mypyconf} build || die "setup.py build failed"
}

src_install() {
	local mypyconf
	python_version
	local site_pkgs=/usr/$(get_libdir)/python${PYVER}/site-packages

	mypyconf="${mypyconf} WX_CONFIG=${WX_CONFIG}"
	use opengl \
		&& mypyconf="${mypyconf} BUILD_GLCANVAS=1" \
		|| mypyconf="${mypyconf} BUILD_GLCANVAS=0"

	mypyconf="${mypyconf} WXPORT=gtk2 UNICODE=1"

	python setup.py ${mypyconf} install --root="${D}" \
		--install-purelib ${site_pkgs} || die "setup.py install failed"

	# Collision protection.
	for file in "${D}"/usr/bin/* "${D}"/${site_pkgs}/wx{version.*,.pth}; do
		mv "${file}" "${file}-${SLOT}"
	done

	for dir in "${D}"/${site_pkgs}/wx-${SLOT}-gtk2-{ansi,unicode}; do
		if [[ -d ${dir} ]]; then
			cp -R "${D}"/${site_pkgs}/wxaddons/ "${dir}"
			wxaddons_copied=1
		fi
	done

	[[ ${wxaddons_copied} ]] && rm -rf "${D}"/${site_pkgs}/wxaddons/
}

pkg_postinst() {
	local site_pkgs=/usr/$(get_libdir)/python${PYVER}/site-packages

	python_mod_optimize ${site_pkgs}

	alternatives_auto_makesym \
		"${site_pkgs}/wx.pth" "${site_pkgs}/wx.pth-[0-9].[0-9]"
	alternatives_auto_makesym \
		"${site_pkgs}/wxversion.py" "${site_pkgs}/wxversion.py-[0-9].[0-9]"

	echo
	elog "Gentoo uses the Multi-version method for SLOT'ing."
	elog "Developers see this site for instructions on using 2.6 or 2.8"
	elog "with your apps:"
	elog "http://wiki.wxpython.org/index.cgi/MultiVersionInstalls"
	echo
}

pkg_postrm() {
	python_mod_cleanup

	local site_pkgs=/usr/$(get_libdir)/python${PYVER}/site-packages

	alternatives_auto_makesym \
		"${site_pkgs}/wx.pth" "${site_pkgs}/wx.pth-[0-9].[0-9]"
	alternatives_auto_makesym \
		"${site_pkgs}/wxversion.py" "${site_pkgs}/wxversion.py-[0-9].[0-9]"
}
