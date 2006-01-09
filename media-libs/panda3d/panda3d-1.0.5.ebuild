# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/panda3d/panda3d-1.0.5.ebuild,v 1.3 2006/01/09 22:16:47 mr_bones_ Exp $

inherit eutils python

DESCRIPTION="A 3D framework in C++ with python bindings"
HOMEPAGE="http://panda3d.org"
SRC_URI="http://panda3d.org/download/${P}.tar.gz"

LICENSE="Panda3D"
SLOT="0"
KEYWORDS="~x86"
IUSE="png jpeg tiff fmod nspr python ssl truetype doc zlib"

DEPEND="doc? ( dev-python/epydoc )
		png? ( media-libs/libpng )
		jpeg? ( media-libs/jpeg )
		tiff? ( media-libs/tiff )
		nspr? ( >=dev-libs/nspr-4.4.1-r2 )
		fmod? ( media-libs/fmod )
		ssl? ( dev-libs/openssl )
		truetype? ( media-libs/freetype )
		zlib? ( sys-libs/zlib )
		python? ( dev-lang/python )"

use_no()
{
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

src_unpack()
{
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-makepanda.patch
}

src_compile()
{
	./makepanda/makepanda.py \
	--compiler LINUXA \
	--prefix built \
	--libdir $(get_libdir) \
	$(use_no python) \
	$(use_no png) $(use_no jpeg) \
	$(use_no tiff) $(use_no fmod) \
	$(use_no ssl) $(use_no truetype freetype) \
	$(use_no zlib) $(use_no nspr) \
	|| die "build failed"
}

src_install()
{
	dodir /opt/panda3d

	doenvd ${FILESDIR}/50panda3d
	sed -i -e "s:lib:$(get_libdir):g" \
	${D}/etc/env.d/50panda3d \
	|| die "libdir patching failed"

	if use doc; then
		cp -R ${S}/samples ${S}/built
		cd ${S}/built
		epydoc --html direct
	fi

	if use python ; then
		# python installation
		python_version
		dodir /usr/$(get_libdir)/python${PYVER}/site-packages
		cat <<- EOF > ${D}/usr/$(get_libdir)/python${PYVER}/site-packages/panda3d.pth
		# This document sets up paths for python to access the
		# panda3d modules
		/opt/panda3d/built
		/opt/panda3d/built/$(get_libdir)
		EOF
	fi

	cp -R ${S}/built/* ${D}/opt/panda3d
	use python && touch ${D}/opt/panda3d/built/__init__.py
}

pkg_postinst()
{
	einfo "Panda3d is installed in /opt/panda3d"
	einfo
	if use doc ; then
		einfo "Documentation is avaliable in /opt/panda3d/html"
		einfo "Samples are avalaible in /opt/panda3d/samples"
	fi
	einfo "For C++ compiling, include directory must be set:"
	einfo "g++ -I/opt/panda3d/include [other flags]"
	if use python ; then
		einfo
		einfo "ppython is depricated and panda3d modules are"
		einfo "now installed as standard python modules."
	fi
	einfo
	einfo "Tutorials avaliable at http://panda3d.org"
}
