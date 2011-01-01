# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cgkit/cgkit-2.0.0_alpha9.ebuild,v 1.3 2011/01/01 21:39:45 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils

MY_P="${P/_/}"

DESCRIPTION="Python library for creating 3D images"
HOMEPAGE="http://cgkit.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

RDEPEND="dev-python/pyrex
	dev-libs/boost[python]
	dev-python/pyprotocols
	dev-python/pyopengl
	dev-python/pygame
	dev-python/imaging
	3ds? ( media-libs/lib3ds )"
DEPEND="${RDEPEND}
	dev-util/scons"

LICENSE="LGPL-2.1 MPL-1.1 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="3ds"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	distutils_src_prepare

	sed -i -e "s/fPIC/fPIC\",\"${CFLAGS// /\",\"}/" supportlib/SConstruct
	cp config_template.cfg config.cfg
	echo 'LIBS += ["GL", "GLU", "glut"]' >> config.cfg
	if use 3ds; then
		echo 'LIB3DS_AVAILABLE = True' >> config.cfg
	fi

	# Ogre viewer is no longer maintained by upstream
	# bug 210731
	#if use ogre; then
	#	echo 'OGRE_AVAILABLE = True' >> config.cfg
	#	echo 'INC_DIRS += ["/usr/include/OGRE"]' >> config.cfg
	#	echo 'MACROS += [("EXT_HASH", None),("GCC_3_1",None)]' >> config.cfg
	#	sed -i -e "s/#include <Math.h>//" wrappers/ogre/OgreCore.h
	#fi

	sed -i -e "s:INC_DIRS = \[\]:INC_DIRS = \['/usr/include'\]:" "${S}"/setup.py

	sed -i -e "160s/as/as_/;168s/as/as_/" cgkit/flockofbirds.py
}

src_compile() {
	pushd supportlib > /dev/null
	scons ${MAKEOPTS}
	popd > /dev/null

	distutils_src_compile
}

src_test() {
	cd unittests
	# Remove failing tests due to non-existing files
	rm test_maimport.py test_mayaascii.py test_mayabinary.py test_ri.py test_slparams.py
	PYTHONPATH="$(ls -d ../build/lib*)" "$(PYTHON)" all.py || die "Tests failed"
}
