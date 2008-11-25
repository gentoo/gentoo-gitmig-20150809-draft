# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/openmesh/openmesh-1.9.6.ebuild,v 1.1 2008/11/25 21:19:52 jsbronder Exp $

EAPI="1"
inherit eutils

MY_PN="OpenMesh"
S=${WORKDIR}/${MY_PN}
DESCRIPTION="A generic and efficient data structure for representing and manipulating polygonal meshes"
HOMEPAGE="http://www.openmesh.org/"
SRC_URI="http://www-i8.informatik.rwth-aachen.de/${MY_PN}/downloads/${MY_PN}-${PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4 debug"

RDEPEND="qt4? ( || ( x11-libs/qt-gui:4 =x11-libs/qt-4.3* ) )"
DEPEND=">=dev-util/acgmake-1.2-r2
	>=sys-apps/findutils-4.3.0
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	use qt4 || sed -i "s:Apps::" ACGMakefile
}

src_compile() {
	if use debug; then
		export CXXDEFS="-UNDEBUG -DDEBUG"
	else
		export CXXDEFS="-DNDEBUG -UDEBUG"
	fi
	acgmake -env || die

	# fix insecure runpaths
	TMPDIR=${S} scanelf -BXRr "${S}" -o /dev/null || die
}

src_install() {
	into /usr
	dolib Core/Linux_gcc_env/libOpenMesh_Core.so
	dolib Tols/Linux_gcc_env/libOpenMesh_Tools.so
	dolib Tools/Subdivider/Adaptive/Composite/Linux_gcc_env/libOpenMesh_Tools_Subdivider_Adaptive_Composite.so

	make clean

	find . -name 'ACGMakefile' -delete
	find . -name '*.vcproj' -delete

	dodir /usr/include/${MY_PN}

	cp -a Core "${D}"/usr/include/${MY_PN}
	cp -a Tools "${D}"/usr/include/${MY_PN}
}
