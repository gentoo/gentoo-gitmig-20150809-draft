# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/imaging/imaging-1.1.4.ebuild,v 1.1 2004/07/19 21:50:44 kloeri Exp $

inherit distutils eutils

MY_P=${P/imaging/Imaging}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Python Imaging Library (PIL)"
HOMEPAGE="http://www.pythonware.com/products/pil/index.htm"
SRC_URI="http://www.effbot.org/downloads/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha ~amd64"
IUSE="tcltk"

DEPEND="virtual/python
	>=media-libs/jpeg-6a
	>=sys-libs/zlib-0.95
	tcltk? ( dev-lang/tk )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-setup.py.patch
	epatch ${FILESDIR}/${P}-fPIC.patch
}

src_compile() {
	export OPT=${CFLAGS}

	#Build the core imaging library (libImaging.a)
	cd ${S}/libImaging
	econf || die "econf failed"
	#Not configured by configure
	sed -e "s:\(JPEGINCLUDE=[[:blank:]]*/usr/\)local/\(include\).*:\1\2:" \
		-i Makefile
	emake || die
	cd ${S}; distutils_src_compile
}

src_install() {
	local mydoc="CHANGES* CONTENTS"
	distutils_src_install
	distutils_python_version

	# install headers required by media-gfx/sketch
	insinto "${ROOT}/usr/include/python${PYVER}"
	doins libImaging/Imaging.h
	doins libImaging/ImPlatform.h
	doins libImaging/ImConfig.h
}
