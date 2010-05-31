# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/panda3d/panda3d-1.5.2.ebuild,v 1.3 2010/05/31 15:12:59 arfrever Exp $

inherit eutils python

DESCRIPTION="A 3D framework in C++ with python bindings"
HOMEPAGE="http://panda3d.org"
SRC_URI="http://panda3d.org/download/${P}/${P}.tar.gz"

LICENSE="Panda3D"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc ffmpeg fftw fmod jpeg openal png python ssl tiff truetype zlib"

DEPEND="doc? ( dev-python/epydoc )
		ffmpeg? ( media-video/ffmpeg )
		fftw? ( sci-libs/fftw )
		fmod? ( =media-libs/fmod-3* )
		jpeg? ( media-libs/jpeg )
		openal? ( media-libs/openal )
		png? ( media-libs/libpng )
		python? ( dev-lang/python )
		ssl? ( dev-libs/openssl )
		tiff? ( media-libs/tiff )
		truetype? ( media-libs/freetype )
		zlib? ( sys-libs/zlib )
		virtual/opengl"

use_no() {
	local UWORD="$2"
	if [ -z "${UWORD}" ]; then
		UWORD="$1"
	fi

	if useq $1 ; then
		echo "--use-${UWORD}"
	else
		echo "--no-${UWORD}"
	fi
}

pkg_setup() {
	ewarn "Please note that python bindings are now"
	ewarn "set by the python USE flag to coordinate"
	ewarn "with upstream."
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	./makepanda/makepanda.py \
		$(use_no ffmpeg) \
		$(use_no fftw) \
		$(use_no fmod) \
		$(use_no jpeg) \
		$(use_no png) \
		$(use_no openal) \
		$(use_no python) \
		$(use_no ssl openssl) \
		$(use_no tiff) \
		$(use_no truetype freetype) \
		$(use_no zlib) \
		|| die "build failed"
}

src_install() {
	dodir /opt/panda3d

	doenvd "${FILESDIR}"/50panda3d
	sed -i -e "s:lib:$(get_libdir):g" \
		"${D}"/etc/env.d/50panda3d \
		|| die "libdir patching failed"

	if use doc; then
		cp -R "${S}"/samples "${S}"/built
		cp -R "${S}"/direct/src "${S}"/built/direct/src
		cd "${S}"/built
	fi

	if use python ; then
		# python installation
		dodir $(python_get_sitedir)
		cat <<- EOF > "${D}"$(python_get_sitedir)/panda3d.pth
		# This document sets up paths for python to access the
		# panda3d modules
		/opt/panda3d
		/opt/panda3d/lib
		/opt/panda3d/direct
		/opt/panda3d/pandac
		/opt/panda3d/built
		/opt/panda3d/built/$(get_libdir)
		EOF
	fi

	cp -R "${S}"/direct/src "${S}"/built/direct/
	cp -R "${S}"/built/* "${D}"/opt/panda3d
}

pkg_postinst()
{
	elog "Panda3d is installed in /opt/panda3d"
	elog
	if use doc ; then
		elog "Documentation is avaliable in /opt/panda3d/doc"
		elog "Samples are avalaible in /opt/panda3d/samples"
	fi
	elog "For C++ compiling, include directory must be set:"
	elog "g++ -I/opt/panda3d/include [other flags]"
	if use python ; then
		elog
		elog "ppython is depricated and panda3d modules are"
		elog "now installed as standard python modules."
	fi
	elog
	elog "Tutorials avaliable at http://panda3d.org"
}
