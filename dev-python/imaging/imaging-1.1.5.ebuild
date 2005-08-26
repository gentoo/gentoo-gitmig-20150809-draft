# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/imaging/imaging-1.1.5.ebuild,v 1.3 2005/08/26 03:30:07 agriffis Exp $

inherit distutils eutils multilib

MY_P=${P/imaging/Imaging}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Python Imaging Library (PIL)"
HOMEPAGE="http://www.pythonware.com/products/pil/index.htm"
SRC_URI="http://www.effbot.org/downloads/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="X tcltk scanner doc"

DEPEND="virtual/python
	>=media-libs/jpeg-6a
	>=sys-libs/zlib-0.95
	>=media-libs/freetype-2.1.5
	tcltk? ( dev-lang/tk )
	scanner? ( media-gfx/sane-backends )
	X? ( media-gfx/xv )"

src_unpack() {
	unpack ${A}
	# look for 64bit libs in lib64
	sed -i -e "s:\"/usr/lib\":\"/usr/$(get_libdir)\":" \
		${S}/setup.py || die "sed failed"
}

src_compile() {
	distutils_src_compile
	if use scanner ; then
		cd ${S}/Sane
		distutils_src_compile
	fi
}

src_install() {

	local mydoc="CHANGES* CONTENTS"
	distutils_src_install

	if use scanner ; then
		cd ${S}/Sane
		local mydoc="CHANGES *"
		docinto "sane"
		distutils_src_install
		cd ${S}
	fi

	# install headers required by media-gfx/sketch
	distutils_python_version
	insinto "${ROOT}/usr/include/python${PYVER}"
	doins libImaging/Imaging.h
	doins libImaging/ImPlatform.h

	if use doc ; then
		insinto "${ROOT}/usr/share/doc/${PF}"
		doins -r Docs
	fi
}
