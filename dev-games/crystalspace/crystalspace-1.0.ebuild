# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/crystalspace/crystalspace-1.0.ebuild,v 1.3 2007/01/31 22:14:56 tupone Exp $

MY_P=${PN}-src-${PV}

DESCRIPTION="Portable 3D Game Development Kit written in C++"
HOMEPAGE="http://crystal.sourceforge.net/"
SRC_URI="mirror://sourceforge/crystal/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="3ds alsa cal3d cegui cg java jpeg mng ode perl png python sdl
truetype vorbis wxwindows"

RDEPEND="virtual/opengl
	virtual/glu
	java? ( virtual/jre )
	cg? ( media-gfx/nvidia-cg-toolkit )
	ode? (  dev-games/ode )
	cal3d? ( =media-libs/cal3d-0.11* )
	jpeg? ( media-libs/jpeg )
	sdl? ( media-libs/libsdl )
	vorbis? ( media-libs/libogg
		      media-libs/libvorbis )
	truetype? ( >=media-libs/freetype-2.1 )
	alsa? ( media-libs/alsa-lib )
	mng? ( media-libs/libmng )
	png? ( media-libs/libpng )
	wxwindows? ( x11-libs/pango
				 x11-libs/wxGTK )
	x11-libs/libXaw
	x11-libs/libXxf86vm"

DEPEND="${RDEPEND}
	3ds? ( media-libs/lib3ds )
	java? ( dev-java/ant-core
			virtual/jdk )
	dev-util/jam
	dev-lang/swig"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf --enable-cpu-specific-optimizations=no \
		--without-lcms \
		$(use_with perl) \
		$(use_with python) \
		$(use_with java) \
		$(use_with png) \
		$(use_with jpeg) \
		$(use_with mng) \
		$(use_with vorbis) \
		$(use_with 3ds) \
		$(use_with ode) \
		$(use_with truetype freetype2) \
		$(use_with cal3d) \
		$(use_with sdl) \
		$(use_with wxwindows wx) \
		$(use_with cegui CEGUI) \
		$(use_with cg Cg) \
		$(use_with alsa asound)
	#remove unwanted CFLAGS added by ./configure
	sed -i -e '/COMPILER\.CFLAGS\.optimize/d' \
		Jamconfig
	jam || die "compile failed"
}

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	# Fill cache directory for the examples
	for dir in castle flarge isomap parallaxtest partsys r3dtest stenciltest \
		terrain terrainf;
	do
		cslight -video=null ${D}/usr/share/${PN}/data/maps/$dir;
	done
	dodoc README

	echo "CRYSTAL_PLUGIN=/usr/lib/crystalspace" >> 90crystalspace
	echo "CRYSTAL_CONFIG=/etc/crystalspace" >> 90crystalspace
	doenvd 90crystalspace
}
