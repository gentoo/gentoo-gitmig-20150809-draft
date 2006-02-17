# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cgkit/cgkit-2.0.0_alpha5.ebuild,v 1.2 2006/02/17 19:03:09 chrb Exp $

inherit distutils flag-o-matic

MY_P=${P/_/}
DESCRIPTION="Python library for creating 3D images"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://cgkit.sourceforge.net"
DEPEND="dev-lang/python
	dev-python/pyrex
	dev-util/scons
	dev-libs/boost
	dev-python/pyprotocols
	dev-python/numarray
	dev-python/pyopengl
	dev-python/pygame
	dev-python/imaging
	3ds? ( media-libs/lib3ds )
	ogre? ( =dev-games/ogre-0.15.1 )"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc"
IUSE="3ds ogre"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
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
}

src_compile() {
	cd ${S}/supportlib
	scons ${MAKEOPTS}
	cd ${S}
	distutils_src_compile
}
