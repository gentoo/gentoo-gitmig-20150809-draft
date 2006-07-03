# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/blender/blender-2.42_pre20060703.ebuild,v 1.1 2006/07/03 21:29:31 lu_zero Exp $

inherit multilib flag-o-matic eutils python

#IUSE="sdl jpeg png mozilla truetype static fmod"
IUSE="openal sdl openexr ffmpeg jpeg png nls iconv blender-game ode"

DESCRIPTION="3D Creation/Animation/Publishing System"
HOMEPAGE="http://www.blender.org/"
#SRC_URI="http://download.blender.org/source/${P}.tar.bz2"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="|| ( GPL-2 BL )"
#KEYWORDS="~amd64 ppc ppc64 ~sparc ~x86"
KEYWORDS="-*"

RDEPEND="
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )
	media-libs/tiff
	nls? ( >=media-libs/freetype-2.0
			 virtual/gettext )
	iconv? ( virtual/libiconv )
	openal? ( ~media-libs/openal-0.0.8
			   media-libs/freealut )
	sdl? ( >=media-libs/libsdl-1.2 )
	ffmpeg? ( media-video/ffmpeg )
	>=dev-libs/openssl-0.9.6
	>=media-gfx/yafray-0.0.7
	nls? ( >=media-libs/ftgl-2.1 )
	openexr? ( media-libs/openexr )
	ode? ( dev-games/ode )
	virtual/opengl"

DEPEND="=dev-util/scons-0.96.1
	|| ( x11-libs/libXt virtual/x11 )
	${RDEPEND}"

S=${WORKDIR}/${PN}


blend_with() {
local UWORD="$2"
	if [ -z "${UWORD}" ]; then
		UWORD="$1"
	fi

	if useq $1; then
		echo "WITH_BF_${UWORD}=1" | tr '[:lower:]' '[:upper:]'
	else
		echo "WITH_BF_${UWORD}=0" | tr '[:lower:]' '[:upper:]'
	fi

return 0
}

src_unpack() {
	unpack ${A}
	mkdir ${WORKDIR}/install/linux2/plugins/
	chmod 755 bmake
#	rm -fR include
	cp -pPR ${S}/source/blender/blenpluginapi include
	cd ${S}
	epatch ${FILESDIR}/blender-2.37-dirs.patch
#	mkdir -p ${WORKDIR}/build/linux2/{extern,intern,source}
}


src_compile() {
	local myconf=""

	myconf="${myconf} $(blend_with openal)"
	myconf="${myconf} $(blend_with sdl)"
	myconf="${myconf} $(blend_with openexr)"
	myconf="${myconf} $(blend_with ffmpeg)"
	myconf="${myconf} $(blend_with jpeg)"
	myconf="${myconf} $(blend_with png)"
	myconf="${myconf} $(blend_with nls international)"
	myconf="${myconf} $(blend_with iconv)"
	myconf="${myconf} $(blend_with blender-game gameengine)"
	myconf="${myconf} $(blend_with ode)"

	scons ${MAKEOPTS} ${myconf} \
			WITH_BF_PLAYER=0

#	sed -i -e "s/-O2/${CFLAGS// /\' ,\'}/g" ${S}/SConstruct
#	scons ${MAKEOPTS} || die
#	cd ${S}/release/plugins
#	emake || die

}

src_install() {
	exeinto /usr/bin/
	doexe ${WORKDIR}/install/linux2/blender

	exeinto /usr/$(get_libdir)/${PN}/textures
	doexe ${WORKDIR}/install/linux2/plugins/texture/*.so
	exeinto /usr/$(get_libdir)/${PN}/sequences
	doexe ${WORKDIR}/install/linux2/plugins/sequence/*.so
	cp -pPR ${S}/install/linux2/plugins \
		${D}/usr/$(get_libdir)/${PN}
	use nls && \
	cp -pPR ${WORKDIR}/install/linux2/.blender/* \
		${D}/usr/$(get_libdir)/${PN}
	insinto /usr/share/pixmaps
	doins ${FILESDIR}/${PN}.png
	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop

	dodoc COPYING INSTALL README

}

pkg_preinst(){
	if [ -h "/usr/$(get_libdir)/blender/plugins/include" ];
	then
		rm -f /usr/$(get_libdir)/blender/plugins/include
	fi
}
