# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Imaging-py21/Imaging-py21-1.1.3-r1.ebuild,v 1.8 2004/03/28 13:55:22 kloeri Exp $

PYTHON_SLOT_VERSION="2.1"

inherit distutils
P_NEW="${PN%-py21}-${PV}"
S="${WORKDIR}/${P_NEW}"

IUSE="tcltk"

DESCRIPTION="Python Imaging Library (PIL)."
SRC_URI="http://www.pythonware.net/storage/${P_NEW}.tar.gz"
HOMEPAGE="http://www.pythonware.com/downloads/#pil"

DEPEND=">=media-libs/jpeg-6a
	>=sys-libs/zlib-0.95
	tcltk? ( dev-lang/tk )"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="as-is"

src_compile() {
	export OPT=${CFLAGS}

	#Build the core imaging library (libImaging.a)
	cd ${S}/libImaging
	econf
	cp Makefile Makefile.orig

	#Not configured by configure
	sed \
		-e "s:\(JPEGINCLUDE=[[:blank:]]*/usr/\)local/\(include\).*:\1\2:" \
	Makefile.orig > Makefile
	emake || die
	cd ${S}
	distutils_src_compile
}

src_install ()
{
	local mydoc="CHANGES* CONTENTS"
	distutils_src_install
	distutils_python_version

	# install headers required by media-gfx/sketch
	insinto "${ROOT}/usr/include/python${PYVER}"
	doins libImaging/Imaging.h
	doins libImaging/ImPlatform.h
	doins libImaging/ImConfig.h
}

