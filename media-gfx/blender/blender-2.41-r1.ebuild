# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/blender/blender-2.41-r1.ebuild,v 1.8 2006/12/06 20:36:50 wolf31o2 Exp $

inherit multilib flag-o-matic eutils python

#IUSE="sdl jpeg png mozilla truetype static fmod"
IUSE="nls"  #blender-game" # blender-plugin"

DESCRIPTION="3D Creation/Animation/Publishing System"
HOMEPAGE="http://www.blender.org/"
SRC_URI="http://download.blender.org/source/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( GPL-2 BL )"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"

RDEPEND="media-libs/libsdl
	media-libs/jpeg
	media-libs/libpng
	media-libs/tiff
	>=media-libs/freetype-2.0
	media-libs/openal
	media-libs/freealut
	>=media-libs/libsdl-1.2
	>=media-libs/libvorbis-1.0
	>=dev-libs/openssl-0.9.6
	>=media-gfx/yafray-0.0.7
	nls? ( >=media-libs/ftgl-2.1 )"

DEPEND="=dev-util/scons-0.96.1
	|| ( x11-libs/libXt virtual/x11 )
	${RDEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}/release/plugins
	chmod 755 bmake
	rm -fR include
	cp -pPR ${S}/source/blender/blenpluginapi include
	cd ${S}
	epatch ${FILESDIR}/blender-2.37-dirs.patch
	mkdir -p ${WORKDIR}/build/linux2/{extern,intern,source}
}


src_compile() {
	local myconf=""

	scons -q

	# SDL Support
	#use sdl && myconf="${myconf} --with-sdl=/usr"
	#	|| myconf="${myconf} --without-sdl"

	# Jpeg support
	#use jpeg && myconf="${myconf} --with-libjpeg=/usr"

	# PNG Support
	#use png && myconf="${myconf} --with-libpng=/usr"

	# ./configure points at the wrong mozilla directories and will fail
	# with this enabled. (A simple patch should take care of this)
	#use mozilla && myconf="${myconf} --with-mozilla=/usr"

	# TrueType support (For text objects)
	#use truetype && myconf="${myconf} --with-freetype2=/usr"

	# Build Staticly
	#use static && myconf="${myconf} --enable-blenderstatic"

	# Build the game engine
#	use blender-game && \
	einfo "enabling game engine"
	sed -i -e "s:BUILD_GAMEENGINE.*$:BUILD_GAMEENGINE = 'true':" \
	config.opts

	if use nls ;
	then
		einfo "enabling internationalization"
		sed -i -e "s:USE_INTERNATIONAL.*$:USE_INTERNATIONAL = 'true':" \
		-e "s:FTGL_INCLUDE.*$:FTGL_INCLUDE = ['/usr/include/FTGL']:"	\
		-e "s:FTGL_LIBPATH.*$:FTGL_LIBPATH = ['/usr/$(get_libdir)']:"				\
		config.opts
	fi

	sed -i \
		-e "s:'openal':'openal','alut':" \
		config.opts

#	use blender-game || \
#	( einfo "disabling game engine"
#	sed -i -e "s:BUILD_GAMEENGINE = 'true':BUILD_GAMEENGINE = 'false':" \
#	${S}/config.opts )

	# Build the plugin
#	use blender-plugin && \
#	( einfo "enabling mozilla plugin"
#	sed -i -e "s:BUILD_BLENDER_PLUGIN.*$:BUILD_BLENDER_PLUGIN = 'true':" \
#	config.opts )

	sed -i -e "s/-O2/${CFLAGS// /\' ,\'}/g" ${S}/SConstruct
	scons ${MAKEOPTS} || die
	cd ${S}/release/plugins
	emake || die

}

src_install() {
	exeinto /usr/bin/
	doexe ${S}/blender

	exeinto /usr/$(get_libdir)/${PN}/textures
	doexe ${S}/release/plugins/texture/*.so
	exeinto /usr/$(get_libdir)/${PN}/sequences
	doexe ${S}/release/plugins/sequence/*.so
	cp -pPR ${S}/release/{datafiles,plugins,scripts} \
		${D}/usr/$(get_libdir)/${PN}
	use nls && \
	cp -pPR ${S}/bin/.blender/{.Blanguages,.bfont.ttf,locale} \
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
