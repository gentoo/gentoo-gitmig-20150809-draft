# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Imaging-py21/Imaging-py21-1.1.4.ebuild,v 1.1 2003/06/22 23:17:12 kutsuya Exp $

PYTHON_SLOT_VERSION="2.1"

inherit distutils
P_NEW="${PN%-py21}-${PV}"
S="${WORKDIR}/${P_NEW}"

IUSE="tcltk"

DESCRIPTION="Python Imaging Library (PIL)."
HOMEPAGE="http://www.pythonware.com/products/pil/index.htm"
SRC_URI="http://www.effbot.org/downloads/${P_NEW}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"
LICENSE="as-is"

DEPEND=">=media-libs/jpeg-6a
	>=sys-libs/zlib-0.95
	tcltk? ( dev-lang/tk )"
	
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
	cd ${S}; distutils_src_compile
	#cd ${S}
	#CFLAGS="$(CFLAGS) -DUSE_COMPOSITELESS_PHOTO_PUT_BLOCK" distutils_src_compile
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

