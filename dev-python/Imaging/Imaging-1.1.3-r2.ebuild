# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Imaging/Imaging-1.1.3-r2.ebuild,v 1.1 2003/05/16 20:38:43 liquidx Exp $ 

inherit distutils

IUSE="tcltk"

DESCRIPTION="Python Imaging Library (PIL)."
SRC_URI="http://www.pythonware.com/downloads/${P}.tar.gz"
HOMEPAGE="http://www.pythonware.com/downloads/#pil"

DEPEND=">=media-libs/jpeg-6a
	>=sys-libs/zlib-0.95
	tcltk? ( dev-lang/tk )"
	
SLOT="0"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"
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
	CFLAGS="$(CFLAGS) -DUSE_COMPOSITELESS_PHOTO_PUT_BLOCK" distutils_src_compile
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

