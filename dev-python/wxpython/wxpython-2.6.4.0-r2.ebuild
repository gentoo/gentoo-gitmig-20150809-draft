# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wxpython/wxpython-2.6.4.0-r2.ebuild,v 1.15 2010/12/12 07:30:02 dirtyepic Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit alternatives eutils fdo-mime python flag-o-matic python wxwidgets

MY_P="${P/wxpython-/wxPython-src-}"

DESCRIPTION="A blending of the wxWindows C++ class library with Python"
HOMEPAGE="http://www.wxpython.org/"
SRC_URI="mirror://sourceforge/wxpython/${MY_P}.tar.bz2"

LICENSE="wxWinLL-3"
SLOT="2.6"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="opengl unicode"

RDEPEND="
	dev-python/setuptools
	>=x11-libs/wxGTK-${PV}:2.6[X,opengl?]
	>=x11-libs/gtk+-2.0
	>=x11-libs/pango-1.2
	>=dev-libs/glib-2.0
	media-libs/libpng
	virtual/jpeg
	media-libs/tiff
	>=sys-libs/zlib-1.1.4
	opengl? ( >=dev-python/pyopengl-2.0.0.44 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}/wxPython"

src_prepare() {
	sed -i "s:cflags.append('-O3'):pass:" config.py || die "sed failed"
	epatch "${FILESDIR}"/scripts-multiver-2.6.1.0.diff

	python_copy_sources
}

src_configure() {
	WX_GTK_VER="2.6"

	if use unicode; then
		need-wxwidgets unicode
	else
		need-wxwidgets ansi
	fi

	append-flags -fno-strict-aliasing

	use opengl \
		&& mypyconf="${mypyconf} BUILD_GLCANVAS=1" \
		|| mypyconf="${mypyconf} BUILD_GLCANVAS=0"

	use unicode \
		&& mypyconf="${mypyconf} UNICODE=1" \
		|| mypyconf="${mypyconf} UNICODE=0"

	mypyconf="${mypyconf} WX_CONFIG=${WX_CONFIG} WXPORT=gtk2"
}

src_compile() {
	building() {
		"$(PYTHON)" setup.py ${mypyconf} build
	}
	python_execute_function -s building
}

src_install() {
	installation() {
		"$(PYTHON)" setup.py ${mypyconf} install --root="${D}" \
			--install-purelib "$(python_get_sitedir)"
	}
	python_execute_function -s installation

	# Collision protection.
	for file in "${D}"usr/bin/*; do
		mv "${file}" "${file}-${SLOT}"
	done

	rename_files() {
		for file in "${D}$(python_get_sitedir)"/wx{version.*,.pth}; do
			mv "${file}" "${file}-${SLOT}" || return 1
		done

		for dir in "${D}$(python_get_sitedir)"/wx-${SLOT}-gtk2-{ansi,unicode}; do
			if [[ -d ${dir} ]]; then
				cp -R "${D}$(python_get_sitedir)"/wxaddons/ "${dir}" || return 1
				wxaddons_copied=1
			fi
		done

		[[ ${wxaddons_copied} ]] && rm -rf "${D}$(python_get_sitedir)"/wxaddons/
	}
	python_execute_function -q rename_files
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	create_symlinks() {
		alternatives_auto_makesym \
			"$(python_get_sitedir)/wx.pth" "$(python_get_sitedir)/wx.pth-[0-9].[0-9]"
		alternatives_auto_makesym \
			"$(python_get_sitedir)/wxversion.py" "$(python_get_sitedir)/wxversion.py-[0-9].[0-9]"
	}
	python_execute_function -q create_symlinks

	use unicode && wxchar=unicode || wxchar=ansi
	python_mod_optimize wx-${SLOT}-gtk2-${wxchar} wxversion.py

	echo
	elog "Gentoo uses the Multi-version method for SLOT'ing."
	elog "Developers see this site for instructions on using 2.6 or 2.8"
	elog "with your apps:"
	elog "http://wiki.wxpython.org/index.cgi/MultiVersionInstalls"
	echo
}

pkg_postrm() {
	python_mod_cleanup wx-${SLOT}-gtk2-${wxchar} wxversion.py
	fdo-mime_desktop_database_update

	create_symlinks() {
		alternatives_auto_makesym \
			"$(python_get_sitedir)/wx.pth" "$(python_get_sitedir)/wx.pth-[0-9].[0-9]"
		alternatives_auto_makesym \
			"$(python_get_sitedir)/wxversion.py" "$(python_get_sitedir)/wxversion.py-[0-9].[0-9]"
	}
	python_execute_function -q create_symlinks
}
