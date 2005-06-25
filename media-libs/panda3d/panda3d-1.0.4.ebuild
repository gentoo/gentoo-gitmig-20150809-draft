# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/panda3d/panda3d-1.0.4.ebuild,v 1.2 2005/06/25 13:31:00 swegener Exp $

inherit eutils

DESCRIPTION="A 3D framework in C++ with python bindings"
HOMEPAGE="http://panda3d.org"
SRC_URI="http://panda3d.org/download/${P}.tar.gz"

LICENSE="Panda3D"
SLOT="0"
KEYWORDS="~x86"
IUSE="png jpeg tiff fmod nspr ssl freetype doc zlib"

DEPEND="doc? ( dev-python/epydoc )
		png? ( media-libs/libpng )
		jpeg? ( media-libs/jpeg )
		tiff? ( media-libs/tiff )
		fmod? ( media-libs/fmod )
		ssl? ( dev-libs/openssl )
		freetype? ( media-libs/freetype )
		zlib? ( sys-libs/zlib )"

use_no()
{
	if useq $1 ; then
		echo "--use-${1}"
	else
		echo "--no-${1}"
	fi
}

src_unpack()
{
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-makepanda.patch
}

src_compile()
{
	./makepanda/makepanda.py \
	--compiler LINUXA \
	--prefix built \
	--libdir $(get_libdir) \
	$(use_no png) $(use_no jpeg) \
	$(use_no tiff) $(use_no fmod) \
	$(use_no ssl) $(use_no freetype) \
	$(use_no zlib) $(use_no nspr) \
	|| die "build failed"
}

src_install()
{
	dodir /opt/panda3d
	cp -R ${S}/direct ${S}/built

	doenvd ${FILESDIR}/50panda3d
	sed -i -e "s:lib:$(get_libdir):g" \
	${D}/etc/env.d/50panda3d \
	|| die "libdir patching failed"

	if use doc; then
		cp -R ${S}/samples ${S}/built
		cd ${S}/built
		epydoc --html direct
	fi

	cp -R ${S}/built/* ${D}/opt/panda3d
}

pkg_postinst()
{
	einfo "Panda3d is installed in /opt/panda3d"
	if use doc ; then
		einfo "Documentation is avaliable in /opt/panda3d/html"
		einfo "Samples are avalaible in /opt/panda3d/samples"
	fi
	einfo "For C++ compiling, include directory must be set:"
	einfo "g++ -I/opt/panda3d/include [other flags]"
	einfo "Python scripts must be ran with ppython"
	einfo "Tutorials avaliable at http://panda3d.org"
}
