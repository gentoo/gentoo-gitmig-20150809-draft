# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/blender/blender-2.63a-r1.ebuild,v 1.1 2012/07/16 00:53:16 flameeyes Exp $

EAPI=4
PYTHON_DEPEND="3:3.2"

PATCHSET="1"

if [[ ${PV} == *9999 ]] ; then
SCM="subversion"
ESVN_REPO_URI="https://svn.blender.org/svnroot/bf-blender/trunk/blender"
fi

inherit multilib scons-utils eutils python versionator flag-o-matic toolchain-funcs pax-utils check-reqs ${SCM}

IUSE="cycles +game-engine player +elbeem +openexr ffmpeg jpeg2k openal
	openmp +dds doc fftw jack apidoc sndfile tweak-mode sdl sse redcode
	iconv collada 3dmouse debug nls"
REQUIRED_USE=""

LANGS="en ar bg ca cs de el es es_ES fa fi fr hr id it ja ky ne pl pt ru sr sr@latin sv tr uk zh_CN zh_TW"
for X in ${LANGS} ; do
	IUSE+=" linguas_${X}"
	REQUIRED_USE+=" linguas_${X}? ( nls )"
done

DESCRIPTION="3D Creation/Animation/Publishing System"
HOMEPAGE="http://www.blender.org"

case ${PV} in
	*9999*)
		SRC_URI="" ;;
	*_p*)
		SRC_URI="http://dev.gentoo.org/~lu_zero/${P}.tar.gz" ;;
	*)
		SRC_URI="http://download.blender.org/source/${P}.tar.gz" ;;
esac

if [[ -n ${PATCHSET} ]]; then
	SRC_URI+=" http://dev.gentoo.org/~flameeyes/${PN}/${P}-patches-${PATCHSET}.tar.bz2"
fi

SLOT="0"
LICENSE="|| ( GPL-2 BL )"
KEYWORDS="~amd64 ~x86"

RDEPEND="virtual/jpeg
	media-libs/libpng:0
	x11-libs/libXi
	x11-libs/libX11
	media-libs/tiff:0
	media-libs/libsamplerate
	virtual/opengl
	>=media-libs/freetype-2.0
	virtual/libintl
	media-libs/glew
	>=sci-physics/bullet-2.78[-double-precision]
	dev-cpp/eigen:3
	sci-libs/colamd
	sys-libs/zlib
	cycles? (
		media-libs/openimageio
		dev-libs/boost
	)
	iconv? ( virtual/libiconv )
	sdl? ( media-libs/libsdl[audio,joystick] )
	openexr? ( media-libs/openexr )
	ffmpeg? (
		>=virtual/ffmpeg-0.6.90[x264,mp3,encode,theora,jpeg2k?]
	)
	openal? ( >=media-libs/openal-1.6.372 )
	fftw? ( sci-libs/fftw:3.0 )
	jack? ( media-sound/jack-audio-connection-kit )
	sndfile? ( media-libs/libsndfile )
	collada? ( media-libs/opencollada )
	3dmouse? ( dev-libs/libspnav )"

DEPEND="dev-util/scons
	apidoc? (
		dev-python/sphinx
		app-doc/doxygen[-nodot(-),dot(+)]
	)
	nls? ( sys-devel/gettext )
	${RDEPEND}"

blend_with() {
	local UWORD="$2"
	[ -z "${UWORD}" ] && UWORD="$1"
	if use $1; then
		echo "WITH_BF_${UWORD}=1" | tr '[:lower:]' '[:upper:]' \
			>> "${S}"/user-config.py
	else
		echo "WITH_BF_${UWORD}=0" | tr '[:lower:]' '[:upper:]' \
			>> "${S}"/user-config.py
	fi
}

if [[ ${PV} == *9999 ]] ; then
	src_unpack() {
		subversion_fetch
	}
fi

pkg_pretend() {
	if use openmp && ! tc-has-openmp; then
		eerror "You are using gcc built without 'openmp' USE."
		eerror "Switch CXX to an OpenMP capable compiler."
		die "Need openmp"
	fi

	if use apidoc; then
		CHECKREQS_DISK_BUILD="4G" check-reqs_pkg_pretend
	fi
}

pkg_setup() {
	python_set_active_version 3
}

src_prepare() {
	EPATCH_SUFFIX="patch" EPATCH_SOURCE="${WORKDIR}/patches" \
		epatch

	# remove some bundled deps
	rm -r \
		extern/libopenjpeg \
		extern/glew \
		extern/Eigen3 \
		extern/bullet2 \
		extern/colamd \
		extern/binreloc

	ewarn "$(echo "Remaining bundled dependencies:";
			find extern -mindepth 1 -maxdepth 1 -type d | sed 's|^|- |')"
}

src_configure() {
	# add system openjpeg into Scons build options.
	cat <<- EOF >> "${S}"/user-config.py
		BF_OPENJPEG="/usr"
		BF_OPENJPEG_INC="/usr/include"
		BF_OPENJPEG_LIB="openjpeg"
	EOF

	# add system sci-physic/bullet into Scons build options.
	cat <<- EOF >> "${S}"/user-config.py
		WITH_BF_BULLET=1
		BF_BULLET="/usr/include"
		BF_BULLET_INC="/usr/include/bullet /usr/include/bullet/BulletCollision /usr/include/bullet/BulletDynamics /usr/include/bullet/LinearMath /usr/include/bullet/BulletSoftBody"
		BF_BULLET_LIB="BulletSoftBody BulletDynamics BulletCollision LinearMath"
	EOF

	# add system sci-libs/colamd into Scons build options.
	cat <<- EOF >> "${S}"/user-config.py
		WITH_BF_COLAMD=1
		BF_COLAMD="/usr"
		BF_COLAMD_INC="/usr/include"
		BF_COLAMD_LIB="colamd"
	EOF

	#add iconv into Scons build options.
	if use !elibc_glibc && use !elibc_uclibc && use iconv; then
		cat <<- EOF >> "${S}"/user-config.py
			WITH_BF_ICONV=1
			BF_ICONV="/usr"
		EOF
	fi

	# configure internationalization optionally
	use nls || echo "WITH_BF_INTERNATIONAL=0" >> "${S}"/user-config.py

	# Ocean sim system needs fftw
	use fftw || echo "WITH_BF_OCEANSIM=0" >> "${S}"/user-config.py

	# configure Tweak Mode
	use tweak-mode && echo "BF_TWEAK_MODE=1" >> "${S}"/user-config.py

	# FIX: Game Engine module needs to be active to build the Blender Player
	if ! use game-engine && use player; then
		elog "Forcing Game Engine [+game-engine] as required by Blender Player [+player]"
		echo "WITH_BF_GAMEENGINE=1" >> "${S}"/user-config.py
	else
		blend_with game-engine gameengine
	fi

	# set CFLAGS used in /etc/make.conf correctly
	echo "CFLAGS=[`for i in ${CFLAGS[@]}; do printf "%s \'$i"\',; done`] " \
		| sed -e "s:,]: ]:" >> "${S}"/user-config.py

	# set CXXFLAGS used in /etc/make.conf correctly
	local FILTERED_CXXFLAGS="`for i in ${CXXFLAGS[@]}; do printf "%s \'$i"\',; done`"
	echo "CXXFLAGS=[${FILTERED_CXXFLAGS}]" | sed -e "s:,]: ]:" >> "${S}"/user-config.py
	echo "BGE_CXXFLAGS=[${FILTERED_CXXFLAGS}]" | sed -e "s:,]: ]:" >> "${S}"/user-config.py

	# reset general options passed to the C/C++ compilers (useless hardcoded flags)
	# FIX: forcing '-funsigned-char' fixes an anti-aliasing issue with menu
	# shadows, see bug #276338 for reference
	echo "CCFLAGS= ['-funsigned-char', '-D_LARGEFILE_SOURCE', '-D_FILE_OFFSET_BITS=64']" >> "${S}"/user-config.py

	# set LDFLAGS used in /etc/make.conf correctly
	local FILTERED_LDFLAGS="`for i in ${LDFLAGS[@]}; do printf "%s \'$i"\',; done`"
	echo "LINKFLAGS=[${FILTERED_LDFLAGS}]" | sed -e "s:,]: ]:" >> "${S}"/user-config.py
	echo "PLATFORM_LINKFLAGS=[${FILTERED_LDFLAGS}]" | sed -e "s:,]: ]:" >> "${S}"/user-config.py

	# reset REL_*/*_WARN variables (useless hardcoded flags)
	cat <<- EOF >> "${S}"/user-config.py
		REL_CFLAGS=[]
		REL_CXXFLAGS=[]
		REL_CCFLAGS=[]
		C_WARN=[]
		CC_WARN=[]
		CXX_WARN=[]
	EOF

	# generic settings which differ from the defaults from linux2-config.py
	cat <<- EOF >> "${S}"/user-config.py
		BF_OPENGL_LIB='GL GLU X11 Xi GLEW'
		BF_INSTALLDIR="../install"
		WITH_PYTHON_SECURITY=1
		WITHOUT_BF_PYTHON_INSTALL=1
		BF_PYTHON="/usr"
		BF_PYTHON_VERSION="3.2"
		BF_PYTHON_ABI_FLAGS=""
		BF_BUILDINFO=0
		BF_QUIET=0
		BF_LINE_OVERWRITE=0
		WITH_BF_FHS=1
		WITH_BF_BINRELOC=0
		WITH_BF_STATICOPENGL=0
		WITH_BF_OPENMP=$(usex openmp 1 0)
		CC="$(tc-getCC)"
		CXX="$(tc-getCXX)"
	EOF

	# configure WITH_BF* Scons build options
	for arg in \
		'elbeem fluid' \
		'sdl' \
		'apidoc docs' \
		'jack' \
		'sndfile' \
		'openexr' \
		'dds' \
		'fftw fftw3' \
		'jpeg2k openjpeg' \
		'openal'\
		'ffmpeg' \
		'ffmpeg ogg' \
		'player' \
		'sse rayoptimization' \
		'redcode' \
		'collada' \
		'3dmouse' ; do
		blend_with ${arg}
	done

	# add system media-libs/opencollada into Scons build options.
	echo 'BF_OPENCOLLADA_INC="/usr/include/opencollada/"' >> "${S}"/user-config.py
	echo 'BF_OPENCOLLADA_LIBPATH="/usr/'$(get_libdir)'/opencollada/"' >> "${S}"/user-config.py

	# enable debugging/testing support
	use debug && echo "BF_DEBUG=1" >> "${S}"/user-config.py
	#use test && echo "BF_UNIT_TEST=1" >> "${S}"/user-config.py

	# enables Cycles render engine
	if use cycles; then
		cat <<- EOF >> "${S}"/user-config.py
			WITH_BF_CYCLES=1
			WITH_BF_OIIO=1
			BF_OIIO="/usr"
			BF_OIIO_INC="/usr/include"
			BF_OIIO_LIB="OpenImageIO"
			WITH_BF_BOOST=1
			BF_BOOST="/usr"
			BF_BOOST_INC="/usr/include/boost"
		EOF
	fi

}

src_compile() {
	escons

	einfo "Generating Blender C/C++ API docs ..."
	cd "${WORKDIR}"/${P}/doc/doxygen
	doxygen -u Doxyfile
	doxygen || die "doxygen failed to build API docs."
}

src_install() {
	# Pax mark blender for hardened support.
	pax-mark m "${WORKDIR}/install/blender"

	# install binaries
	dobin "${WORKDIR}/install/blender"
	use player && newbin "${WORKDIR}/install/blenderplayer" blenderplayer

	# install plugin headers
	insinto /usr/include/${PN}
	doins "${WORKDIR}"/${P}/source/blender/blenpluginapi/*.h

	# install desktop file
	insinto /usr/share/pixmaps
	doins release/freedesktop/icons/scalable/apps/blender.svg
	insinto /usr/share/applications
	doins release/freedesktop/blender.desktop

	# install docs
	doman "${WORKDIR}"/${P}/doc/manpage/blender.1
	use doc && dodoc -r "${WORKDIR}"/${P}/doc/guides/*

	if use apidoc; then
		#einfo "Generating (BPY) Blender Python API docs ..."
		"${D}"/usr/bin/blender --background --python doc/python_api/sphinx_doc_gen.py --noaudio || die "blender failed."

		pushd doc/python_api > /dev/null
		sphinx-build sphinx-in BPY_API || die "sphinx failed."
		popd > /dev/null

		docinto "API/python"
		dohtml -r doc/python_api/BPY_API/*

		docinto "API/blender"
		dohtml -r "${WORKDIR}"/${P}/doc/doxygen/html/*
	fi

	# final cleanup
	rm -r "${WORKDIR}"/install/{Python-license.txt,icons,GPL-license.txt,copyright.txt}
	if ! use nls; then
		rm -r "${WORKDIR}/install/${PV/a}/datafiles/locale"
	else
		for x in "${WORKDIR}"/install/${PV/a}/datafiles/locale/* ; do
			mylang=${x##*/}
			use linguas_${mylang} || rm -r ${x}
		done
	fi

	# installing blender
	insinto /usr/share/${PN}
	doins -r "${WORKDIR}"/install/${PV/a}/*

	# FIX: making all python scripts readable only by group 'users',
	#	  so nobody can modify scripts apart root user, but python
	#	  cache (*.pyc) can be written and shared across the users.
#	chown root:users -R "${D}/usr/share/${PN}/${SLOT}/scripts" || die
#	chmod 755 -R "${D}/usr/share/${PN}/${SLOT}/scripts" || die
}

pkg_postinst() {
	elog
	elog "Blender uses python integration. As such, may have some"
	elog "inherit risks with running unknown python scripting."
	elog
	elog "It is recommended to change your blender temp directory"
	elog "from /tmp to /home/user/tmp or another tmp file under your"
	elog "home directory. This can be done by starting blender, then"
	elog "dragging the main menu down do display all paths."
	elog
}
