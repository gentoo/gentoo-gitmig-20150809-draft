# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cgkit/cgkit-2.0.0_alpha3-r1.ebuild,v 1.1 2005/04/22 12:11:44 chrb Exp $

inherit distutils flag-o-matic

MY_P=${P/_/}
DESCRIPTION="Python library for creating 3D images"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://cgkit.sourceforge.net"
# note: this could be split into depend/rdepend if someone takes the time
# also many of these are optional. local use flags would be nice.
DEPEND="dev-lang/python
	dev-python/pyrex
	dev-util/scons
	dev-libs/boost
	dev-python/pyprotocols
	dev-python/numarray
	dev-python/pyopengl
	dev-python/pygame
	dev-python/imaging
	3ds? media-libs/lib3ds
	ogre? dev-games/ogre"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="3ds ogre"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	append-flags -fPIC
	sed -i -e "s/CFLAGS = \"\"/CFLAGS = \"${CFLAGS}\"/" ${S}/supportlib/SConstruct
	cd ${S}
	cp config_template.cfg config.cfg
	echo 'LIBS += ["GL", "GLU", "glut"]' >> config.cfg
	if use 3ds; then
		echo 'LIB3DS_AVAILABLE = True' >> config.cfg
	fi
	if use ogre; then
		echo 'OGRE_AVAILABLE = True' >> config.cfg
	fi
}

src_compile() {
	cd ${S}/supportlib
	scons ${MAKEOPTS}
	cd ${S}
	distutils_src_compile
}
