# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/blender/blender-2.42a.ebuild,v 1.5 2006/10/23 20:10:55 lu_zero Exp $

inherit multilib flag-o-matic eutils python

#IUSE="sdl jpeg png mozilla truetype static fmod"
IUSE="openal sdl openexr jpeg png nls iconv blender-game ffmpeg"

DESCRIPTION="3D Creation/Animation/Publishing System"
HOMEPAGE="http://www.blender.org/"
SRC_URI="http://download.blender.org/source/${P}.tar.gz"


SLOT="0"
LICENSE="|| ( GPL-2 BL )"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"


RDEPEND="
	jpeg? ( media-libs/jpeg )
	png? ( media-libs/libpng )
	media-libs/tiff
	nls? ( >=media-libs/freetype-2.0
			virtual/libintl )
	iconv? ( virtual/libiconv )
	openal? ( ~media-libs/openal-0.0.8
			   media-libs/freealut )
	sdl? ( >=media-libs/libsdl-1.2 )
	ffmpeg? ( ~media-video/ffmpeg-0.4.9_p20060530 )
	~media-libs/x264-svn-20060612
	>=dev-libs/openssl-0.9.6
	>=media-gfx/yafray-0.0.7
	nls? ( >=media-libs/ftgl-2.1 )
	openexr? ( media-libs/openexr )
	virtual/opengl"

DEPEND="=dev-util/scons-0.96.1
	|| ( x11-libs/libXt virtual/x11 )
	${RDEPEND}"

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
	mkdir -p ${WORKDIR}/install/linux2/plugins/
#	chmod 755 bmake
#	rm -fR include
	cd ${WORKDIR}/install/linux2/plugins/
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
	myconf="${myconf} $(blend_with jpeg)"
	myconf="${myconf} $(blend_with ffmpeg)"
	myconf="${myconf} $(blend_with png)"
	myconf="${myconf} $(blend_with nls international)"
	myconf="${myconf} $(blend_with iconv)"
	myconf="${myconf} $(blend_with blender-game gameengine)"

	scons ${MAKEOPTS} ${myconf} \
			WITH_BF_PLAYER=0 || die

#	sed -i -e "s/-O2/${CFLAGS// /\' ,\'}/g" ${S}/SConstruct
#	scons ${MAKEOPTS} || die
	cd ${WORKDIR}/install/linux2/plugins/
	chmod 755 bmake
	emake || die

}

src_install() {
	exeinto /usr/bin/
	doexe ${WORKDIR}/install/linux2/blender

	dodir /usr/share/${PN}

	exeinto /usr/$(get_libdir)/${PN}/textures
	doexe ${WORKDIR}/install/linux2/plugins/texture/*.so
	exeinto /usr/$(get_libdir)/${PN}/sequences
	doexe ${WORKDIR}/install/linux2/plugins/sequence/*.so
	insinto /usr/include/blender/
	doins ${WORKDIR}/install/linux2/plugins/include/*.h
	use nls && \
	cp -pPR ${WORKDIR}/install/linux2/.blender/{.Blanguages,.bfont.ttf,locale}\
		${D}/usr/share/${PN}
	cp -pPR ${WORKDIR}/install/linux2/.blender/scripts ${D}/usr/share/${PN}

	mv ${D}/usr/share/${PN}/locale ${D}/usr/share

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
