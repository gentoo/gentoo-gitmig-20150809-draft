# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/blender/blender-2.48a-r3.ebuild,v 1.17 2011/10/30 12:59:41 sping Exp $

EAPI=2

inherit scons-utils multilib flag-o-matic eutils python

#IUSE="jpeg mozilla png sdl static truetype"
IUSE="blender-game ffmpeg jpeg nls openal openexr openmp
	player png quicktime verse"
DESCRIPTION="3D Creation/Animation/Publishing System"
HOMEPAGE="http://www.blender.org/"
SRC_URI="http://download.blender.org/source/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( GPL-2 BL )"
KEYWORDS="amd64 ppc ppc64 x86"

RDEPEND=">=dev-libs/openssl-0.9.6
	ffmpeg? ( virtual/ffmpeg )
	jpeg? ( virtual/jpeg )
	media-libs/tiff
	>=dev-lang/python-2.4
	nls? ( >=media-libs/freetype-2.0
			virtual/libintl
			>=media-libs/ftgl-2.1 )
	openal? ( >=media-libs/openal-1.6.372
		>=media-libs/freealut-1.1.0-r1 )
	openexr? ( media-libs/openexr )
	png? ( media-libs/libpng )
	quicktime? ( media-libs/libquicktime )
	>=media-libs/libsdl-1.2
	blender-game? ( >=media-libs/libsdl-1.2[joystick] )
	virtual/opengl"

DEPEND=">=dev-util/scons-0.98
	x11-libs/libXt
	x11-proto/inputproto
	${RDEPEND}"

blend_with() {
	local UWORD="$2"
	if [ -z "${UWORD}" ]; then
		UWORD="$1"
	fi
	if use $1; then
		echo "WITH_BF_${UWORD}=1" | tr '[:lower:]' '[:upper:]' \
			>> "${S}"/user-config.py
	else
		echo "WITH_BF_${UWORD}=0" | tr '[:lower:]' '[:upper:]' \
			>> "${S}"/user-config.py
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.37-dirs.patch
	epatch "${FILESDIR}"/${PN}-2.44-scriptsdir.patch
	epatch "${FILESDIR}"/${PN}-2.46-ffmpeg.patch
	epatch "${FILESDIR}"/${PN}-2.46-cve-2008-1103-1.patch
	epatch "${FILESDIR}"/${PN}-2.48-ffmpeg-20081014.patch
	epatch "${FILESDIR}"/${P}-CVE-2008-4863.patch
}

src_configure() {
	if use ffmpeg ; then
#		cd "${S}"/extern
#		rm -rf ffmpeg libmp3lame x264
		cat <<- EOF >> "${S}"/user-config.py
		BF_FFMPEG="/usr"
		BF_FFMPEG_LIB="avformat avcodec swscale avutil"
		EOF
	fi
	# pass compiler flags to the scons build system
	# and set python version to current version in use
	cat <<- EOF >> "${S}"/user-config.py
		CFLAGS += '${CFLAGS}'
		BF_PYTHON_VERSION="$(python_get_version)"
		BF_PYTHON_INC="$(python_get_includedir)"
		BF_PYTHON_BINARY="$(PYTHON -a)"
		BF_PYTHON_LIB="python$(python_get_version)"
	EOF

	if use openmp && built_with_use --missing false sys-devel/gcc openmp ; then
		echo "WITH_BF_OPENMP=1" >> "${S}"/user-config.py
		elog "enabling openmp"
	else
		echo "WITH_BF_OPENMP=0" >> "${S}"/user-config.py
		elog "disabling openmp"
	fi

	for arg in \
			'blender-game gameengine' \
			'ffmpeg' \
			'jpeg' \
			'nls international' \
			'openal' \
			'openexr' \
			'player' \
			'png' \
			'verse' ; do
		blend_with ${arg}
	done
}

src_compile() {
	escons || die \
	"!!! Please add ${S}/scons.config when filing bugs reports to bugs.gentoo.org"

	cd "${WORKDIR}"/install/linux2/plugins
	chmod 755 bmake
	emake || die
}

src_install() {
	exeinto /usr/bin/
	doexe "${WORKDIR}"/install/linux2/blender
	use player && doexe "${WORKDIR}"/install/linux2/blenderplayer

	dodir /usr/share/${PN}

	exeinto /usr/$(get_libdir)/${PN}/textures
	doexe "${WORKDIR}"/install/linux2/plugins/texture/*.so
	exeinto /usr/$(get_libdir)/${PN}/sequences
	doexe "${WORKDIR}"/install/linux2/plugins/sequence/*.so
	insinto /usr/include/${PN}
	doins "${WORKDIR}"/install/linux2/plugins/include/*.h

	if use nls ; then
		mv "${WORKDIR}"/install/linux2/.blender/{.Blanguages,.bfont.ttf} \
			"${D}"/usr/share/${PN}
		mv "${WORKDIR}"/install/linux2/.blender/locale \
			"${D}"/usr/share/locale
	fi

	mv "${WORKDIR}"/install/linux2/.blender/scripts "${D}"/usr/share/${PN}

	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/${PN}.png
	insinto /usr/share/applications
	doins "${FILESDIR}"/${PN}.desktop

	dodoc INSTALL README
	dodoc "${WORKDIR}"/install/linux2/BlenderQuickStart.pdf
}

pkg_preinst(){
	if [ -h "${ROOT}/usr/$(get_libdir)/blender/plugins/include" ];
	then
		rm -f "${ROOT}"/usr/$(get_libdir)/blender/plugins/include
	fi
}
