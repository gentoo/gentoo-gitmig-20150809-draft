# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cgkit/cgkit-2.0.0_alpha7.ebuild,v 1.4 2008/05/22 14:45:33 bicatali Exp $

inherit distutils flag-o-matic

MY_P=${P/_/}
DESCRIPTION="Python library for creating 3D images"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://cgkit.sourceforge.net"
RDEPEND="dev-lang/python
	dev-python/pyrex
	dev-libs/boost
	dev-python/pyprotocols
	dev-python/pyopengl
	dev-python/pygame
	dev-python/imaging
	3ds? ( media-libs/lib3ds )
	ogre? ( =dev-games/ogre-0.15.1 )"
DEPEND="${RDEPEND}
	dev-util/scons"

SLOT="0"
LICENSE="LGPL-2.1 MPL-1.1 GPL-2"
KEYWORDS="~ppc x86"
IUSE="3ds ogre"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s/fPIC/fPIC\",\"${CFLAGS// /\",\"}/" supportlib/SConstruct
	cp config_template.cfg config.cfg
	echo 'LIBS += ["GL", "GLU", "glut"]' >> config.cfg
	if use 3ds; then
		echo 'LIB3DS_AVAILABLE = True' >> config.cfg
	fi
	if use ogre; then
		echo 'OGRE_AVAILABLE = True' >> config.cfg
		echo 'INC_DIRS += ["/usr/include/OGRE"]' >> config.cfg
		echo 'MACROS += [("EXT_HASH", None),("GCC_3_1",None)]' >> config.cfg
		sed -i -e "s/#include <Math.h>//" wrappers/ogre/OgreCore.h
	fi
	sed -i -e "s:INC_DIRS = \[\]:INC_DIRS = \['/usr/include'\]:" "${S}"/setup.py
}

src_compile() {
	cd "${S}"/supportlib
	scons ${MAKEOPTS}
	cd "${S}"
	distutils_src_compile
}
