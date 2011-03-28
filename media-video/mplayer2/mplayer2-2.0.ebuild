# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer2/mplayer2-2.0.ebuild,v 1.1 2011/03/28 22:59:02 lu_zero Exp $

EAPI=4

[[ ${PV} = *9999* ]] && VCS_ECLASS="git" || VCS_ECLASS=""

inherit toolchain-funcs eutils flag-o-matic multilib base ${VCS_ECLASS}

namesuf="${PN/mplayer/}"

IUSE="3dnow 3dnowext +a52 aalib +alsa altivec aqua +ass bidi bindist bl bluray
bs2b +bzip2 cddb +cdio cdparanoia cpudetection custom-cpuopts custom-cflags debug dga +dirac
directfb doc +dts +dv dvb +dvd +dvdnav dxr3 +enca esd +faad fbcon
ftp gif ggi gsm +iconv ipv6 jack joystick jpeg jpeg2k kernel_linux ladspa
libcaca lirc +live mad md5sum +mmx mmxext mng +mp3 mpg123 nas
+network nut amr +opengl +osdmenu oss png pnm pulseaudio pvr +quicktime
radio +rar +real +rtc rtmp samba +shm +schroedinger +hardcoded-tables sdl +speex sse sse2 ssse3
tga +theora threads +truetype +unicode v4l v4l2 vdpau
+vorbis vpx win32codecs +X xanim xinerama +xscreensaver +xv xvmc
"
IUSE+=" system-ffmpeg symlink"

VIDEO_CARDS="s3virge mga tdfx vesa"
for x in ${VIDEO_CARDS}; do
	IUSE+=" video_cards_${x}"
done

FONT_URI="
	mirror://mplayer/releases/fonts/font-arial-iso-8859-1.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-iso-8859-2.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-cp1250.tar.bz2
"
if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="git://repo.or.cz/mplayer-build.git"
	EGIT_PROJECT="${PN}-build"
	RELEASE_URI=""
else
	RELEASE_URI="http://ftp.mplayer2.org/pub/release/${PN}-build-${PV/_/-}.tar.xz"
fi
SRC_URI="${RELEASE_URI}
	!truetype? ( ${FONT_URI} )
"

DESCRIPTION="Media Player for Linux"
HOMEPAGE="http://www.mplayer2.org/"

FONT_RDEPS="
	virtual/ttf-fonts
	media-libs/fontconfig
	>=media-libs/freetype-2.2.1:2
"
X_RDEPS="
	x11-libs/libXext
	x11-libs/libXxf86vm
"
# Rar: althrought -gpl version is nice, it cant do most functions normal rars can
#	nemesi? ( net-libs/libnemesi )
RDEPEND+="
	sys-libs/ncurses
	sys-libs/zlib
	!bindist? (
		x86? (
			win32codecs? ( media-libs/win32codecs )
		)
	)
	X? (
		${X_RDEPS}
		dga? ( x11-libs/libXxf86dga )
		ggi? (
			media-libs/libggi
			media-libs/libggiwmh
		)
		opengl? ( virtual/opengl )
		vdpau? ( x11-libs/libvdpau )
		xinerama? ( x11-libs/libXinerama )
		xscreensaver? ( x11-libs/libXScrnSaver )
		xv? (
			x11-libs/libXv
			xvmc? ( x11-libs/libXvMC )
		)
	)
	a52? ( media-libs/a52dec )
	aalib? ( media-libs/aalib )
	alsa? ( media-libs/alsa-lib )
	ass? ( ${FONT_RDEPS} >=media-libs/libass-0.9.10[enca?,fontconfig] )
	bidi? ( dev-libs/fribidi )
	bluray? ( media-libs/libbluray )
	bs2b? ( media-libs/libbs2b )
	cdio? ( dev-libs/libcdio )
	cdparanoia? ( !cdio? ( media-sound/cdparanoia ) )
	directfb? ( dev-libs/DirectFB )
	dts? ( media-libs/libdca )
	dv? ( media-libs/libdv )
	dvb? ( media-tv/linuxtv-dvb-headers )
	dvd? (
		>=media-libs/libdvdread-4.1.3
		dvdnav? ( >=media-libs/libdvdnav-4.1.3 )
	)
	esd? ( media-sound/esound )
	enca? ( app-i18n/enca )
	faad? ( media-libs/faad2 )
	gif? ( media-libs/giflib )
	iconv? ( virtual/libiconv )
	jack? ( media-sound/jack-audio-connection-kit )
	jpeg? ( virtual/jpeg )
	ladspa? ( media-libs/ladspa-sdk )
	libcaca? ( media-libs/libcaca )
	lirc? ( app-misc/lirc )
	live? ( media-plugins/live )
	mad? ( media-libs/libmad )
	mng? ( media-libs/libmng )
	mpg123? ( media-sound/mpg123 )
	nas? ( media-libs/nas )
	nut? ( >=media-libs/libnut-661 )
	png? ( media-libs/libpng )
	pnm? ( media-libs/netpbm )
	pulseaudio? ( media-sound/pulseaudio )
	rar? (
		|| (
			app-arch/unrar
			app-arch/rar
		)
	)
	samba? ( net-fs/samba )
	sdl? ( media-libs/libsdl )
	speex? ( media-libs/speex )
	theora? ( media-libs/libtheora )
	truetype? ( ${FONT_RDEPS} )
	vorbis? ( media-libs/libvorbis )
	xanim? ( media-video/xanim )
	system-ffmpeg? (
		>=media-video/ffmpeg-0.6_p25423[amr?,bzip2?,dirac?,gsm?,hardcoded-tables?,jpeg2k?,rtmp?,schroedinger?,threads?,vpx?]
	)
	!system-ffmpeg? (
		amr? ( media-libs/opencore-amr )
		bzip2? ( app-arch/bzip2 )
		dirac? ( media-video/dirac )
		gsm? ( >=media-sound/gsm-1.0.12-r1 )
		jpeg2k? ( >=media-libs/openjpeg-1.3-r2 )
		rtmp? ( media-video/rtmpdump )
		schroedinger? ( media-libs/schroedinger )
		vpx? ( media-libs/libvpx )
	)
	symlink? ( !media-video/mplayer )
"

X_DEPS="
	x11-proto/videoproto
	x11-proto/xf86vidmodeproto
"
ASM_DEP="dev-lang/yasm"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-lang/python
	sys-devel/gettext
	X? (
		${X_DEPS}
		dga? ( x11-proto/xf86dgaproto )
		dxr3? ( media-video/em8300-libraries )
		xinerama? ( x11-proto/xineramaproto )
		xscreensaver? ( x11-proto/scrnsaverproto )
	)
	amd64? ( ${ASM_DEP} )
	doc? (
		dev-libs/libxslt app-text/docbook-xml-dtd
		app-text/docbook-xsl-stylesheets
	)
	x86? ( ${ASM_DEP} )
	x86-fbsd? ( ${ASM_DEP} )
"

SLOT="0"
LICENSE="GPL-3"
if [[ ${PV} != *9999* ]]; then
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
	S="${WORKDIR}/${PN}-build-${PV}"
else
	KEYWORDS=""
fi

# bindist does not cope with amr codecs (#299405#c6), win32codecs are nonfree
# libcdio support: prefer libcdio over cdparanoia and don't check for cddb w/cdio
# dvd navigation requires dvd read support
# ass and freetype font require iconv and ass requires freetype fonts
# unicode transformations are usefull only with iconv
# libvorbis require external tremor to work
# radio requires oss or alsa backend
# xvmc requires xvideo support
REQUIRED_USE="bindist? ( !win32codecs )"

PATCHES=(
)

pkg_setup() {
	if [[ ${PV} == *9999* ]]; then
		elog
		elog "This is a live ebuild which installs the latest from upstream's"
		elog "${VCS_ECLASS} repository, and is unsupported by Gentoo."
		elog "Everything but bugs in the ebuild itself will be ignored."
		elog
	fi

	if use cpudetection; then
		ewarn
		ewarn "You've enabled the cpudetection flag. This feature is"
		ewarn "included mainly for people who want to use the same"
		ewarn "binary on another system with a different CPU architecture."
		ewarn "MPlayer will already detect your CPU settings by default at"
		ewarn "buildtime; this flag is used for runtime detection."
		ewarn "You won't need this turned on if you are only building"
		ewarn "mplayer for this system. Also, if your compile fails, try"
		ewarn "disabling this use flag."
	fi

	if use custom-cpuopts; then
		ewarn
		ewarn "You are using the custom-cpuopts flag which will"
		ewarn "specifically allow you to enable / disable certain"
		ewarn "CPU optimizations."
		ewarn
		ewarn "Most desktop users won't need this functionality, but it"
		ewarn "is included for corner cases like cross-compiling and"
		ewarn "certain profiles. If unsure, disable this flag and MPlayer"
		ewarn "will automatically detect and use your available CPU"
		ewarn "optimizations."
		ewarn
		ewarn "Using this flag means your build is unsupported, so"
		ewarn "please make sure your CPU optimization use flags (3dnow"
		ewarn "3dnowext mmx mmxext sse sse2 ssse3) are properly set."
	fi

	if use system-ffmpeg; then
		ewarn "System ffmpeg will be used. If you want ffmpeg-mt, disable"
		ewarn "\"system-ffmpeg\" or use ffmpeg package with \"ffmpeg-mt\" enabled."
	else
		ewarn "Internal ffmpeg-mt will be used. If you don't want it, enable \"system-ffmpeg\"."
	fi
}

src_unpack() {
	if [[ ${PV} = *9999* ]]; then
		git_src_unpack

		EGIT_REPO_URI="git://repo.or.cz/mplayer.git"
		EGIT_PROJECT="${PN}"
		S+="/mplayer"
		git_fetch
		S="${WORKDIR}/${P}"

		if ! use system-ffmpeg; then
			EGIT_BRANCH="mt"
			EGIT_COMMIT="mt"
			S+="/ffmpeg-mt"
			EGIT_REPO_URI="git://repo.or.cz/FFMpeg-mirror/mplayer-patches.git"
			EGIT_PROJECT="${PN}-ffmpeg"
			git_fetch
			EGIT_BRANCH="master"
			unset EGIT_COMMIT

			cd "${S}"
			EGIT_REPO_URI="git://git.mplayerhq.hu/libswscale"
			EGIT_PROJECT="libswscale"
			EGIT_COMMIT="$(git submodule status -- libswscale|sed -e 's/^-\(.*\) .*/\1/')"
			S+="/${EGIT_PROJECT}"
			git_fetch

			S="${WORKDIR}/${P}"
		fi

		cd "${WORKDIR}"
	else
		unpack ${A}
	fi

	if ! use truetype; then
		unpack font-arial-iso-8859-1.tar.bz2 \
			font-arial-iso-8859-2.tar.bz2 \
			font-arial-cp1250.tar.bz2
	fi
}

src_prepare() {
	if [[ ${PV} = *9999* ]]; then
		git_src_prepare
		# Set GIT version manually
		pushd mplayer
		echo "GIT-r$(git rev-list HEAD|wc -l)-$(git describe --always)" \
			> VERSION || die
		popd
	fi

	# remove internal libs and use system:
	sed -e '/^mplayer: /s/libass//' \
		-i Makefile || die
	rm -rf \
		libass \
		|| die

	if use system-ffmpeg; then
		sed -e '/^mplayer: /s/ffmpeg//' \
			-i Makefile || die
		rm -rf ffmpeg-mt || die
	else
		sed -i \
			-e "/'--cpu=host',/d" \
			-e "/'--disable-debug',/d" \
			-e "/'--enable-pthreads',/d" \
			script/ffmpeg-config || die
	fi

	# fix path to bash executable in configure scripts
	local bash_scripts="mplayer/configure mplayer/version.sh"
	use system-ffmpeg || bash_scripts+=" ffmpeg*/configure ffmpeg*/version.sh"
	sed -i -e "1c\#!${EPREFIX}/bin/bash" \
		${bash_scripts} || die

	# We want mplayer${namesuf}
	if [[ "${namesuf}" != "" ]]; then
		pushd mplayer
		sed -e "/elif linux ; then/a\  _exesuf=\"${namesuf}\"" \
			-i configure || die
		sed -e "/ -m 644 DOCS\/man\/en\/mplayer/i\	mv DOCS\/man\/en\/mplayer.1 DOCS\/man\/en\/mplayer${namesuf}.1" \
			-e "/ -m 644 DOCS\/man\/\$(lang)\/mplayer/i\	mv DOCS\/man\/\$(lang)\/mplayer.1 DOCS\/man\/\$(lang)\/mplayer${namesuf}.1" \
			-e "s/er.1/er${namesuf}.1/g" \
			-i Makefile || die
		sed -e "s/mplayer/mplayer${namesuf}/" \
			-i TOOLS/midentify.sh || die
		popd
	fi

	base_src_prepare
}

src_configure() {
	local myconf=""
	local uses i

	# set LINGUAS
	[[ -n $LINGUAS ]] && LINGUAS="${LINGUAS/da/dk}"

	# mplayer ebuild uses "use foo || --disable-foo" to forcibly disable
	# compilation in almost every situation. The reason for this is
	# because if --enable is used, it will force the build of that option,
	# regardless of whether the dependency is available or not.

	###################
	#Optional features#
	###################
	# disable svga since we don't want it
	# disable arts since we don't have kde3
	# disable tremor, it needs libvorbisidec and is for FPU-less systems only
	myconf+="
		--disable-svga
		--disable-arts
		--disable-kai
		--disable-tremor
		$(use_enable network networking)
		$(use_enable joystick)
	"
	uses="ass bl bluray enca ftp rtc" # nemesi <- not working with in-tree ebuild
	myconf+=" --disable-nemesi" # nemesi automagic disable
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use bidi || myconf+=" --disable-fribidi"
	use ipv6 || myconf+=" --disable-inet6"
	use nut || myconf+=" --disable-libnut"
	use rar || myconf+=" --disable-unrarexec"
	use samba || myconf+=" --disable-smb"
	if ! use lirc; then
		myconf+="
			--disable-lirc
			--disable-lircc
			--disable-apple-ir
		"
	fi

	# libcdio support: prefer libcdio over cdparanoia
	# don't check for cddb w/cdio
	if use cdio; then
		myconf+=" --disable-cdparanoia"
	else
		myconf+=" --disable-libcdio"
		use cdparanoia || myconf+=" --disable-cdparanoia"
		use cddb || myconf+=" --disable-cddb"
	fi

	################################
	# DVD read, navigation support #
	################################
	#
	# dvdread - accessing a DVD
	# dvdnav - navigation of menus
	#
	# use external libdvdcss, dvdread and dvdnav
	myconf+=" --disable-dvdread-internal --disable-libdvdcss-internal"
	if use dvd; then
		use dvdnav || myconf+=" --disable-dvdnav"
	else
		myconf+="
			--disable-dvdnav
			--disable-dvdread
		"
	fi

	#############
	# Subtitles #
	#############
	#
	# SRT/ASS/SSA (subtitles) requires freetype support
	# freetype support requires iconv
	# iconv optionally can use unicode
	if ! use ass && ! use truetype; then
		myconf+=" --disable-freetype"
		if ! use iconv; then
			myconf+="
				--disable-iconv
				--charset=noconv
			"
		fi
	fi
	use iconv && use unicode && myconf+=" --charset=UTF-8"

	#####################################
	# DVB / Video4Linux / Radio support #
	#####################################
	myconf+=" --disable-tv-bsdbt848"
	# broken upstream, won't work with recent kernels
	myconf+=" --disable-ivtv"
	if { use dvb || use v4l || use v4l2 || use pvr || use radio; }; then
		use dvb || myconf+=" --disable-dvb"
		use pvr || myconf+=" --disable-pvr"
		use v4l || myconf+=" --disable-tv-v4l1"
		use v4l2 || myconf+=" --disable-tv-v4l2"
		if use radio && { use dvb || use v4l || use v4l2; }; then
			myconf+="
				--enable-radio
				--disable-radio-capture
			"
		else
			myconf+="
				--disable-radio-v4l2
				--disable-radio-bsdbt848
			"
		fi
	else
		myconf+="
			--disable-tv
			--disable-tv-v4l1
			--disable-tv-v4l2
			--disable-radio
			--disable-radio-v4l2
			--disable-radio-bsdbt848
			--disable-dvb
			--disable-v4l2
			--disable-pvr"
	fi

	##########
	# Codecs #
	##########
	myconf+=" --disable-musepack" # deprecated, libavcodec Musepack decoder is preferred
	use dts || myconf+=" --disable-libdca"
	if ! use mp3; then
		myconf+="
			--disable-mp3lib
		"
	fi
	uses="a52 bs2b dv vorbis"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-lib${i}"
	done
	uses="faad gif jpeg live mad mng mpg123 png pnm speex tga theora xanim"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done

	# Encoding
	uses="xvid"
	for i in ${uses}; do
		myconf+=" --disable-${i}"
	done

	#################
	# Binary codecs #
	#################
	# bug 213836
	if ! use x86 || ! use win32codecs; then
		use quicktime || myconf+=" --disable-qtx"
	fi

	######################
	# RealPlayer support #
	######################
	# Realplayer support shows up in four places:
	# - libavcodec (internal)
	# - win32codecs
	# - realcodecs (win32codecs libs)
	# - realcodecs (realplayer libs)

	# internal
	use real || myconf+=" --disable-real"

	# Real binary codec support only available on x86, amd64
	if use real; then
		use x86 && myconf+=" --codecsdir=/opt/RealPlayer/codecs"
		use amd64 && myconf+=" --codecsdir=/usr/$(get_libdir)/codecs"
	fi
	myconf+=" $(use_enable win32codecs win32dll)"

	################
	# Video Output #
	################
	uses="directfb md5sum sdl"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	use aalib || myconf+=" --disable-aa"
	use fbcon || myconf+=" --disable-fbdev"
	use fbcon && use video_cards_s3virge && myconf+=" --enable-s3fb"
	use libcaca || myconf+=" --disable-caca"

	if ! use kernel_linux || ! use video_cards_mga; then
		 myconf+=" --disable-mga --disable-xmga"
	fi

	if use video_cards_tdfx; then
		myconf+="
			$(use_enable video_cards_tdfx tdfxvid)
			$(use_enable fbcon tdfxfb)
		"
	else
		myconf+="
			--disable-3dfx
			--disable-tdfxvid
			--disable-tdfxfb
		"
	fi

	# sun card, disable by default, see bug #258729
	myconf+=" --disable-xvr100"

	################
	# Audio Output #
	################
	uses="alsa esd jack ladspa nas"
	for i in ${uses}; do
		use ${i} || myconf+=" --disable-${i}"
	done
	#use openal && myconf+=" --enable-openal" # build fails
	use pulseaudio || myconf+=" --disable-pulse"
	if ! use radio; then
		use oss || myconf+=" --disable-ossaudio"
	fi

	####################
	# Advanced Options #
	####################
	# Platform specific flags, hardcoded on amd64 (see below)
	use cpudetection && myconf+=" --enable-runtime-cpudetection"

	# Turning off CPU optimizations usually will break the build.
	# However, this use flag, if enabled, will allow users to completely
	# specify which ones to use. If disabled, mplayer will automatically
	# enable all CPU optimizations that the host build supports.
	if use custom-cpuopts; then
		uses="3dnow 3dnowext altivec mmx mmxext shm sse sse2 ssse3"
		for i in ${uses}; do
			myconf+=" $(use_enable ${i})"
		done
	fi

	use debug && myconf+=" --enable-debug=3"

	if use x86 && gcc-specs-pie; then
		filter-flags -fPIC -fPIE
		append-ldflags -nopie
	fi

	is-flag -O? || append-flags -O2

	# workaround bug, x86 just has too few registers, see c.f.
	# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=402950#44
	# and 32-bits OSX, bug 329861
	if [[ ${CHOST} == i?86-* ]] ; then
		use debug || append-flags -fomit-frame-pointer
	fi

	###########################
	# X enabled configuration #
	###########################
	if use X; then
		uses="dxr3 ggi xinerama"
		for i in ${uses}; do
			use ${i} || myconf+=" --disable-${i}"
		done
		use dga || myconf+=" --disable-dga1 --disable-dga2"
		use opengl || myconf+=" --disable-gl"
		use osdmenu && myconf+=" --enable-menu"
		use vdpau || myconf+=" --disable-vdpau"
		use video_cards_vesa || myconf+=" --disable-vesa"
		use xscreensaver || myconf+=" --disable-xss"

		if use xv; then
			if use xvmc; then
				myconf+=" --enable-xvmc --with-xvmclib=XvMCW"
			else
				myconf+=" --disable-xvmc"
			fi
		else
			myconf+="
				--disable-xv
				--disable-xvmc
			"
			use xvmc && elog "Disabling xvmc because it requires \"xv\" useflag enabled."
		fi
	else
		myconf+="
			--disable-dga1
			--disable-dga2
			--disable-dxr3
			--disable-ggi
			--disable-gl
			--disable-vdpau
			--disable-xinerama
			--disable-xss
			--disable-xv
			--disable-xvmc
			--disable-x11
		"
		uses="dga dxr3 ggi opengl osdmenu vdpau xinerama xscreensaver xv"
		for i in ${uses}; do
			use ${i} && elog "Useflag \"${i}\" require \"X\" useflag enabled to work."
		done
	fi

	############################
	# OSX (aqua) configuration #
	############################
	if use aqua; then
		myconf+="
			--enable-macosx-finder
			--enable-macosx-bundle
		"
	fi

	common_options="
		--cc=$(tc-getCC)
		--host-cc=$(tc-getBUILD_CC)
	"
	myconf+="
		--prefix="${EPREFIX}"/usr
		--bindir="${EPREFIX}"/usr/bin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--confdir="${EPREFIX}"/etc/mplayer
		--datadir="${EPREFIX}"/usr/share/mplayer${namesuf}
		--mandir="${EPREFIX}"/usr/share/man
		--localedir="${EPREFIX}"/usr/share/locale
		--enable-translation
		"

	echo "${common_options}" > common_options
	echo "${myconf}" > mplayer_options

	if ! use system-ffmpeg; then
		local ffconf="
			--enable-gpl
			--enable-version3
			--enable-postproc
			--disable-stripping
			"

		# enabled by default
		use debug || ffconf+=" --disable-debug"
		use network || ffconf+=" --disable-network"
		use bzip2 || ffconf+=" --disable-bzlib"

		use custom-cflags && ffconf+=" --disable-optimizations"
		use cpudetection && ffconf+=" --enable-runtime-cpudetect"

		# Threads; we only support pthread for now but ffmpeg supports more
		use threads || ffconf+=" --disable-pthreads"

		# ffmpeg encoders
		for i in faac mp3lame theora vorbis x264 xvid; do
			ffconf+=" --disable-lib${i}"
		done

		# ffmpeg decoders
		use amr && ffconf+=" --enable-libopencore-amrwb --enable-libopencore-amrnb"
		for i in gsm dirac rtmp schroedinger speex vpx; do
			use ${i} && ffconf+=" --enable-lib${i}"
		done
		use jpeg2k && ffconf+=" --enable-libopenjpeg"

		# CPU features
		for i in mmx ssse3 altivec ; do
			use ${i} || ffconf+=" --disable-${i}"
		done
		use mmxext || ffconf+=" --disable-mmx2"
		use 3dnow || ffconf+=" --disable-amd3dnow"
		use 3dnowext || ffconf+=" --disable-amd3dnowext"
		# disable mmx accelerated code if PIC is required
		# as the provided asm decidedly is not PIC.
		if gcc-specs-pie ; then
			ffconf+=" --disable-mmx --disable-mmx2"
		fi

		# Try to get cpu type based on CFLAGS.
		# Bug #172723
		# We need to do this so that features of that CPU will be better used
		# If they contain an unknown CPU it will not hurt since ffmpeg's configure
		# will just ignore it.
		for i in $(get-flag march) $(get-flag mcpu) $(get-flag mtune) ; do
			[ "${i}" = "native" ] && i="host" # bug #273421
			[[ ${i} = *-sse3 ]] && i="${i%-sse3}" # bug 283968
			ffconf+=" --cpu=${i}"
			break
		done

		# cross compile support
		if tc-is-cross-compiler ; then
			ffconf+=" --enable-cross-compile --arch=$(tc-arch-kernel) --cross-prefix=${CHOST}-"
			case ${CHOST} in
				*freebsd*)
					ffconf+=" --target-os=freebsd"
					;;
				mingw32*)
					ffconf+=" --target-os=mingw32"
					;;
				*linux*)
					ffconf+=" --target-os=linux"
					;;
			esac
		fi

		# Misc stuff
		use hardcoded-tables && ffconf+=" --enable-hardcoded-tables"

		echo "${ffconf}" > ffmpeg_options
	fi

	sed -i \
		-e 's/\t//g' \
		-e 's/ --/\n--/g' \
		-e '/^$/d' \
		*_options || die
}

src_compile() {
	base_src_compile
	# Build only user-requested docs if they're available.
	if use doc ; then
		pushd mplayer
		# select available languages from $LINGUAS
		LINGUAS=${LINGUAS/zh/zh_CN}
		local ALLOWED_LINGUAS="cs de en es fr hu it pl ru zh_CN"
		local BUILT_DOCS=""
		for i in ${LINGUAS} ; do
			hasq ${i} ${ALLOWED_LINGUAS} && BUILT_DOCS+=" ${i}"
		done
		if [[ -z $BUILT_DOCS ]]; then
			emake -j1 -C DOCS/xml html-chunked
		else
			for i in ${BUILT_DOCS}; do
				emake -j1 -C DOCS/xml html-chunked-${i}
			done
		fi
	fi
}

src_install() {
	local i

	emake \
		DESTDIR="${D}" \
		INSTALLSTRIP="" \
		install

	S+="/mplayer"
	cd "${S}"
	dodoc AUTHORS Copyright README etc/codecs.conf

	docinto tech/
	dodoc DOCS/tech/{*.txt,mpsub.sub,playtree}
	docinto TOOLS/
	dodoc -r TOOLS
	if use real; then
		docinto tech/realcodecs/
		dodoc DOCS/tech/realcodecs/*
	fi

	if use doc; then
		docinto html/
		dohtml -r "${S}"/DOCS/HTML/*
	fi

	if ! use ass && ! use truetype; then
		dodir /usr/share/mplayer${namesuf}/fonts
		# Do this generic, as the mplayer people like to change the structure
		# of their zips ...
		for i in $(find "${WORKDIR}/" -type d -name 'font-arial-*'); do
			cp -pPR "${i}" "${ED}/usr/share/mplayer${namesuf}/fonts"
		done
		# Fix the font symlink ...
		rm -rf "${ED}/usr/share/mplayer${namesuf}/font"
		dosym fonts/font-arial-14-iso-8859-1 /usr/share/mplayer${namesuf}/font
	fi

	if use symlink; then
		insinto /etc/mplayer
		newins "${S}/etc/example.conf" mplayer.conf
		doins "${S}/etc/input.conf"
		if use osdmenu; then
			doins "${S}/etc/menu.conf"
		fi

		if use ass || use truetype; then
			cat >> "${ED}/etc/mplayer/mplayer.conf" << _EOF_
fontconfig=1
subfont-osd-scale=4
subfont-text-scale=3
_EOF_
		fi

		# bug 256203
		if use rar; then
			cat >> "${ED}/etc/mplayer/mplayer.conf" << _EOF_
unrarexec=${EPREFIX}/usr/bin/unrar
_EOF_
		fi

		dosym ../../../etc/mplayer/mplayer.conf /usr/share/mplayer${namesuf}/mplayer.conf
	fi

	newbin "${S}/TOOLS/midentify.sh" midentify${namesuf}

	if [[ "${namesuf}" != "" ]] && use symlink; then
		dosym "mplayer${namesuf}" /usr/bin/mplayer
		dosym "midentify${namesuf}" /usr/bin/midentify
	fi
}

pkg_postrm() {
	# Cleanup stale symlinks
	[ -L "${EROOT}/usr/share/mplayer${namesuf}/font" -a \
			! -e "${EROOT}/usr/share/mplayer${namesuf}/font" ] && \
		rm -f "${EROOT}/usr/share/mplayer${namesuf}/font"
}
