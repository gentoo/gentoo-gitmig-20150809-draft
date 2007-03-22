# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer/mplayer-1.0_rc2_pre20070321-r2.ebuild,v 1.1 2007/03/22 15:08:56 beandog Exp $

inherit eutils flag-o-matic multilib

RESTRICT="nostrip"
IUSE="3dnow 3dnowext a52 aac aalib alsa altivec amr arts bidi bl bindist cddb
cpudetection custom-cflags debug dga doc dts dvb cdparanoia directfb dvd dvdnav
dv dvdread enca encode esd fbcon ftp gif ggi gtk iconv ipv6 ivtv jack joystick
jpeg libcaca lirc live livecd lzo mad md5sum mmx mmxext mp2 mp3 musepack nas unicode vorbis opengl openal oss png pnm quicktime radio rar real rtc samba sdl speex srt sse sse2 svga theora tivo truetype v4l v4l2 win32codecs X x264 xanim xinerama xv xvid xvmc zoran"

LANGS="bg cs da de el es fr hu it ja ko mk nb no pl ro ru sk sv tr uk pt_BR zh_CN zh_TW"

VIDEO_CARDS="s3virge mga tdfx tga vesa"

for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done

for X in ${VIDEO_CARDS}; do
	IUSE="${IUSE} video_cards_${X}"
done

BLUV=1.7
SVGV=1.9.17

S="${WORKDIR}/${PN}"
AMR_URI="http://www.3gpp.org/ftp/Specs/archive"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	!truetype? ( mirror://mplayer/releases/fonts/font-arial-iso-8859-1.tar.bz2
				 mirror://mplayer/releases/fonts/font-arial-iso-8859-2.tar.bz2
				 mirror://mplayer/releases/fonts/font-arial-cp1250.tar.bz2 )
	!iconv? ( mirror://mplayer/releases/fonts/font-arial-iso-8859-1.tar.bz2
			  mirror://mplayer/releases/fonts/font-arial-iso-8859-2.tar.bz2
			  mirror://mplayer/releases/fonts/font-arial-cp1250.tar.bz2 )
	svga? ( http://mplayerhq.hu/~alex/svgalib_helper-${SVGV}-mplayer.tar.bz2 )
	gtk? ( mirror://mplayer/Skin/Blue-${BLUV}.tar.bz2 )
	amr? ( ${AMR_URI}/26_series/26.104/26104-510.zip
		   ${AMR_URI}/26_series/26.204/26204-510.zip )"

DESCRIPTION="Media Player for Linux "
HOMEPAGE="http://www.mplayerhq.hu/"

RDEPEND="sys-libs/ncurses
	win32codecs? (
		!livecd? (
			!bindist? ( media-libs/win32codecs ) ) )
	x86? ( real? ( !bindist? ( media-video/realplayer ) ) )
	amd64? ( real? ( !bindist? ( media-libs/amd64codecs ) ) )
	x86? ( mp2? ( media-sound/toolame ) )
	amd64? ( mp2? ( media-sound/toolame ) )
	aalib? ( media-libs/aalib )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	openal? ( media-libs/openal )
	bidi? ( dev-libs/fribidi )
	cdparanoia? ( media-sound/cdparanoia )
	directfb? ( dev-libs/DirectFB )
	dts? ( media-libs/libdts )
	dvb? ( media-tv/linuxtv-dvb-headers )
	dvd? ( dvdread? ( media-libs/libdvdread ) )
	encode? (
		media-sound/lame
		dv? ( media-libs/libdv )
		x264? ( media-libs/x264-svn )
		aac? ( media-libs/faac )
		)
	esd? ( media-sound/esound )
	enca? ( app-i18n/enca )
	gif? ( media-libs/giflib )
	ggi? ( media-libs/libggi )
	gtk? ( media-libs/libpng
		x11-libs/libXxf86vm
		x11-libs/libXext
		x11-libs/libXi
		=x11-libs/gtk+-2* )
	jpeg? ( media-libs/jpeg )
	libcaca? ( media-libs/libcaca )
	lirc? ( app-misc/lirc )
	lzo? ( =dev-libs/lzo-1* )
	mad? ( media-libs/libmad )
	musepack? ( >=media-libs/libmpcdec-1.2.2 )
	nas? ( media-libs/nas )
	opengl? ( virtual/opengl )
	png? ( media-libs/libpng )
	pnm? ( media-libs/netpbm )
	samba? ( net-fs/samba )
	sdl? ( media-libs/libsdl )
	speex? ( media-libs/speex )
	srt? ( >=media-libs/freetype-2.1
		media-libs/fontconfig )
	svga? ( media-libs/svgalib )
	!hppa? ( !ppc64? ( tdfx? ( x11-libs/libXxf86vm
		x11-libs/libXext
		x11-drivers/xf86-video-tdfx ) ) )
	theora? ( media-libs/libtheora )
	live? ( >=media-plugins/live-2007.02.20 )
	truetype? ( >=media-libs/freetype-2.1
		media-libs/fontconfig )
	video_cards_mga? ( x11-libs/libXxf86vm
		x11-libs/libXext
		x11-drivers/xf86-video-mga )
	video_cards_s3virge? ( x11-libs/libXxf86vm
		x11-libs/libXext
		x11-drivers/xf86-video-s3virge )
	video_cards_tga? ( x11-libs/libXxf86vm
		x11-libs/libXext
		x11-drivers/xf86-video-tga )
	video_cards_vesa? ( x11-libs/libXxf86vm
		x11-libs/libXext
		x11-drivers/xf86-video-vesa )
	xinerama? ( x11-libs/libXinerama
		x11-libs/libXxf86vm
		x11-libs/libXext )
	xanim? ( media-video/xanim )
	xv? ( x11-libs/libXv
		x11-libs/libXxf86vm
		x11-libs/libXext
		xvmc? ( x11-libs/libXvMC ) )
	xvid? ( media-libs/xvid )
	X? ( x11-libs/libXxf86vm
		x11-libs/libXext
		joystick? ( x11-drivers/xf86-input-joystick )
	)"

DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( >=app-text/docbook-sgml-dtd-4.1.2
		app-text/docbook-xml-dtd
		>=app-text/docbook-xml-simple-dtd-1.50.0
		dev-libs/libxslt
	)
	dga? ( x11-proto/xf86dgaproto )
	xinerama? ( x11-proto/xineramaproto )
	xv? ( x11-proto/videoproto
		  x11-proto/xf86vidmodeproto )
	gtk? ( x11-proto/xextproto
		   x11-proto/xf86vidmodeproto )
	X? ( x11-proto/xextproto
		 x11-proto/xf86vidmodeproto )
	iconv? ( virtual/libiconv )"
# Make sure the assembler USE flags are unmasked on amd64
# Remove this once default-linux/amd64/2006.1 is deprecated
DEPEND="${DEPEND} amd64? ( >=sys-apps/portage-2.1.2 )
	ivtv? ( !x86-fbsd? ( <sys-kernel/linux-headers-2.6.20
		media-tv/ivtv
		>=sys-apps/portage-2.1.2 ) )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

src_unpack() {

	unpack ${P}.tar.bz2

	if ! use truetype ; then
		unpack font-arial-iso-8859-1.tar.bz2 \
			font-arial-iso-8859-2.tar.bz2 \
			font-arial-cp1250.tar.bz2
	fi

	use svga && unpack svgalib_helper-${SVGV}-mplayer.tar.bz2

	use gtk && unpack Blue-${BLUV}.tar.bz2

	use amr && unpack 26104-510.zip && unpack 26204-510.zip

	# amr (float) support
	if use amr; then
		einfo "Including amr wide and narrow band (float) support ... "

		# narrow band codec
		mkdir ${S}/libavcodec/amr_float
		cd ${S}/libavcodec/amr_float
		unzip -q ${WORKDIR}/26104-510_ANSI_C_source_code.zip
		# wide band codec
		mkdir ${S}/libavcodec/amrwb_float
		cd ${S}/libavcodec/amrwb_float
		unzip -q ${WORKDIR}/26204-510_ANSI-C_source_code.zip
	fi

	cd ${S}

	# Fix hppa compilation
	# [ "${ARCH}" = "hppa" ] && sed -i -e "s/-O4/-O1/" "${S}/configure"

	if use svga
	then
		echo
		einfo "Enabling vidix non-root mode."
		einfo "(You need a proper svgalib_helper.o module for your kernel"
		einfo " to actually use this)"
		echo

		mv ${WORKDIR}/svgalib_helper ${S}/libdha
	fi

	# Remove kernel-2.6 workaround as the problem it works around is
	# fixed, and the workaround breaks sparc
	# use sparc && sed -i 's:#define __KERNEL__::' osdep/kerneltwosix.h

	# minor fix
	# sed -i -e "s:-O4:-O4 -D__STDC_LIMIT_MACROS:" configure

	# Fix XShape detection
	epatch ${FILESDIR}/${PN}-xshape.patch

}

src_compile() {

	local myconf=" --disable-tv-bsdbt848 \
		--disable-vidix-external \
		--disable-faad-external \
		--disable-libcdio"

	# have fun with LINGUAS variable
	[[ -n $LINGUAS ]] && LINGUAS=${LINGUAS/da/dk}
	local myconf_linguas="--language=en"
	for x in ${LANGS}; do
		if use linguas_${x}; then
			myconf_linguas="${myconf_linguas} --language=${x}"
		fi
	done
	myconf="${myconf} ${myconf_linguas}"

	################
	#Optional features#
	###############
	if use cpudetection || use livecd || use bindist
	then
		myconf="${myconf} --enable-runtime-cpudetection"
	fi

	use bidi || myconf="${myconf} --disable-fribidi"
	use bl && myconf="${myconf} --enable-bl"
	use cddb || myconf="${myconf} --disable-cddb"
	use cdparanoia || myconf="${myconf} --disable-cdparanoia"
	use enca || myconf="${myconf} --disable-enca"
	use ftp || myconf="${myconf} --disable-ftp"
	use srt || myconf="${myconf} --disable-ass"
	use tivo || myconf="${myconf} --disable-vstream"

	if use iconv && use unicode; then
		myconf="${myconf} --charset=UTF-8"
	else
		myconf="${myconf} --disable-iconv --charset=noconv"
	fi

	# DVD support
	# dvdread and libdvdcss are internal libs
	# http://www.mplayerhq.hu/DOCS/HTML/en/dvd.html
	# You can optionally use external dvdread support, but against
	# upstream's suggestion.  We don't.
	# dvdnav support is known to be buggy, but it is the only option
	# for accessing some DVDs.
	if use dvd
	then
		use dvdread || myconf="${myconf} --disable-dvdread"
		use dvdnav || myconf="${myconf} --disable-dvdnav"
	else
		myconf="${myconf} --disable-dvdnav --disable-dvdread"
	fi

	if use encode
	then
		use dv || myconf="${myconf} --disable-libdv"
		use x264 || myconf="${myconf} --disable-x264"
		use aac || myconf="${myconf} --disable-faac"
	else
		myconf="${myconf} --disable-mencoder --disable-libdv --disable-x264
		--disable-faac"
	fi

	if ! use srt; then
		use truetype || myconf="${myconf} --disable-freetype"
	fi
	use lirc || myconf="${myconf} --disable-lirc --disable-lircc"
	myconf="${myconf} $(use_enable joystick)"
	use ipv6 || myconf="${myconf} --disable-inet6"
	use rar || myconf="${myconf} --disable-unrarlib"
	use rtc || myconf="${myconf} --disable-rtc"
	use samba || myconf="${myconf} --disable-smb"

	# Video4Linux / Radio support
	if ( use v4l || use v4l2 || use radio ); then
		use v4l	|| myconf="${myconf} --disable-tv-v4l1"
		use v4l2 || myconf="${myconf} --disable-tv-v4l2"
		if use radio; then
			myconf="${myconf} --enable-radio $(use_enable encode radio-capture)"
		else
			myconf="${myconf} --disable-radio-v4l2 --disable-radio-bsdbt848"
		fi
	else
		myconf="${myconf} --disable-tv --disable-tv-v4l1 --disable-tv-v4l2 \
			--disable-radio --disable-radio-v4l2 --disable-radio-bsdbt848"
	fi

	# disable PVR support
	# The build will break if you have media-tv/ivtv installed and
	# linux-headers != 2.6.18, which is currently not keyworded
	# See also, bug 164748
	myconf="${myconf} --disable-pvr"

	#########
	# Codecs #
	########
	for x in gif jpeg live mad musepack pnm speex theora xanim xvid; do
		use ${x} || myconf="${myconf} --disable-${x}"
	done
	use aac || myconf="${myconf} --disable-faad-internal"
	use a52 || myconf="${myconf} --disable-liba52"
	use dts || myconf="${myconf} --disable-libdts"
	! use png && ! use gtk && myconf="${myconf} --disable-png"
	use lzo || myconf="${myconf} --disable-liblzo"
	use mp2 || myconf="${myconf} --disable-twolame --disable-toolame"
	use mp3 || myconf="${myconf} --disable-mp3lib"
	use quicktime || myconf="${myconf} --disable-qtx"
	use vorbis || myconf="${myconf} --disable-libvorbis"
	use xanim && myconf="${myconf} --xanimcodecsdir=/usr/lib/xanim/mods"
	if use x86 || use amd64; then
		# Real codec support, only available on x86, amd64
		if use real && use x86; then
			myconf="${myconf} --realcodecsdir=/opt/RealPlayer/codecs"
		elif use real && use amd64; then
			myconf="${myconf} --realcodecsdir=/usr/$(get_libdir)/codecs"
		else
			myconf="${myconf} --disable-real"
		fi
		! use livecd && ! use bindist && \
			myconf="${myconf} $(use_enable win32codecs win32dll)"
	fi

	#############
	# Video Output #
	#############

	#use aalib && myconf="${myconf} --enable-aa"
	for x in directfb ivtv ggi md5sum sdl xinerama; do
		use ${x} || myconf="${myconf} --disable-${x}"
	done
	use aalib || myconf="${myconf} --disable-aa"
	use dvb || myconf="${myconf} --disable-dvb --disable-dvbhead"
	use fbcon || myconf="${myconf} --disable-fbdev"
	use fbcon && use video_cards_s3virge && myconf="${myconf} --enable-s3fb"
	use libcaca || myconf="${myconf} --disable-caca"
	use opengl || myconf="${myconf} --disable-gl"
	use svga ||	myconf="${myconf} --disable-vidix-internal"
	use video_cards_mga || myconf="${myconf} --disable-mga"
	( use X && use video_cards_mga ) || myconf="${myconf} --disable-xmga"
	use video_cards_tga || myconf="${myconf} --disable-tga"
	use video_cards_vesa || myconf="${myconf} --disable-vesa"
	use zoran || myconf="${myconf} --disable-zr"

	# GTK gmplayer gui
	myconf="${myconf} $(use_enable gtk gui)"

	if use xv; then
		if use xvmc; then
			myconf="${myconf} --enable-xvmc --with-xvmclib=XvMCW"
		else
			myconf="${myconf} --disable-xvmc"
		fi
	else
		myconf="${myconf} --disable-xv --disable-xvmc"
	fi

	if use video_cards_tdfx; then
		myconf="${myconf} $(use_enable video_cards_tdfx tdfxvid) \
			$(use_enable fbcon tdfxfb)"
	else
		myconf="${myconf} --disable-3dfx --disable-tdfxvid --disable-tdfxfb"
	fi

	#############
	# Audio Output #
	#############
	for x in alsa arts esd jack nas openal; do
		use ${x} || myconf="${myconf} --disable-${x}"
	done
	use oss || myconf="${myconf} --disable-ossaudio"

	#################
	# Advanced Options #
	#################
	# Platform specific flags, hardcoded on amd64 (see below)
	for x in 3dnow 3dnowext mmx mmxext sse sse2; do
		use ${x} || myconf="${myconf} --disable-${x}"
	done
	use debug && myconf="${myconf} --enable-debug=3"

	if use ppc64 && use altivec; then
		myconf="${myconf} --enable-altivec"
		append-flags -maltivec -mabi=altivec
	else
		myconf="${myconf} --disable-altivec"
	fi

	if [ -e /dev/.devfsd ]; then
		myconf="${myconf} --enable-linux-devfs"
	fi

	#leave this in place till the configure/compilation borkage is completely corrected back to pre4-r4 levels.
	# it's intended for debugging so we can get the options we configure mplayer w/, rather then hunt about.
	# it *will* be removed asap; in the meantime, doesn't hurt anything.
	echo "${myconf}" > ${T}/configure-options

	if use custom-cflags; then
		# let's play the filtration game!  MPlayer hates on all!
		strip-flags
		# ugly optimizations cause MPlayer to cry on x86 systems!
			if use x86 ; then
				replace-flags -O* -O2
				filter-flags -fPIC -fPIE
				use debug || append-flags -fomit-frame-pointer
			fi
		append-flags -D__STDC_LIMIT_MACROS
	else
		unset CFLAGS CXXFLAGS
	fi

	myconf="--cc=$(tc-getCC) \
		--host-cc=$(tc-getBUILD_CC) \
		--prefix=/usr \
		--confdir=/usr/share/mplayer \
		--datadir=/usr/share/mplayer \
		--libdir=/usr/$(get_libdir) \
		--enable-largefiles \
		--enable-menu \
		--enable-network \
		${myconf}"
	einfo "Running ./configure"
	echo "CFLAGS=\"${CFLAGS}\" ./configure ${myconf}"
	CFLAGS="${CFLAGS}" ./configure ${myconf} || die

	# we run into problems if -jN > -j1
	# see #86245
	MAKEOPTS="${MAKEOPTS} -j1"

	einfo "Make"
	emake || die "Failed to build MPlayer!"
	use doc && make -C DOCS/xml html-chunked
	einfo "Make completed"
}

src_install() {

	einfo "Make install"
	make prefix=${D}/usr \
		 BINDIR=${D}/usr/bin \
		 LIBDIR=${D}/usr/$(get_libdir) \
		 CONFDIR=${D}/usr/share/mplayer \
		 DATADIR=${D}/usr/share/mplayer \
		 MANDIR=${D}/usr/share/man \
		 install || die "Failed to install MPlayer!"
	einfo "Make install completed"

	dodoc AUTHORS ChangeLog README
	# Install the documentation; DOCS is all mixed up not just html
	if use doc ; then
		find "${S}/DOCS" -type d | xargs -- chmod 0755
		find "${S}/DOCS" -type f | xargs -- chmod 0644
		cp -r "${S}/DOCS" "${D}/usr/share/doc/${PF}/" || die
	fi

	# Copy misc tools to documentation path, as they're not installed directly
	# and yes, we are nuking the +x bit.
	find "${S}/TOOLS" -type d | xargs -- chmod 0755
	find "${S}/TOOLS" -type f | xargs -- chmod 0644
	cp -r "${S}/TOOLS" "${D}/usr/share/doc/${PF}/" || die

	# Install the default Skin and Gnome menu entry
	if use gtk; then
		dodir /usr/share/mplayer/skins
		cp -r ${WORKDIR}/Blue ${D}/usr/share/mplayer/skins/default || die

		# Fix the symlink
		rm -rf ${D}/usr/bin/gmplayer
		dosym mplayer /usr/bin/gmplayer

		insinto /usr/share/pixmaps
		newins ${S}/Gui/mplayer/pixmaps/logo.xpm mplayer.xpm
		insinto /usr/share/applications
		doins ${FILESDIR}/mplayer.desktop
	fi

	if ! use truetype; then
		dodir /usr/share/mplayer/fonts
		local x=
		# Do this generic, as the mplayer people like to change the structure
		# of their zips ...
		for x in $(find ${WORKDIR}/ -type d -name 'font-arial-*')
		do
			cp -pPR ${x} ${D}/usr/share/mplayer/fonts
		done
		# Fix the font symlink ...
		rm -rf ${D}/usr/share/mplayer/font
		dosym fonts/font-arial-14-iso-8859-1 /usr/share/mplayer/font
	fi

	insinto /etc
	newins ${S}/etc/example.conf mplayer.conf

	dosym ../../../etc/mplayer.conf /usr/share/mplayer/mplayer.conf

	#mv the midentify script to /usr/bin for emovix.
	#cp ${D}/usr/share/doc/${PF}/TOOLS/midentify ${D}/usr/bin
	#chmod a+x ${D}/usr/bin/midentify
	dobin ${D}/usr/share/doc/${PF}/TOOLS/midentify

	insinto /usr/share/mplayer
	doins ${S}/etc/input.conf
	doins ${S}/etc/menu.conf
}

pkg_preinst() {

	if [ -d "${ROOT}/usr/share/mplayer/Skin/default" ]
	then
		rm -rf ${ROOT}/usr/share/mplayer/Skin/default
	fi
}

pkg_postinst() {

	if use video_cards_mga; then
		depmod -a &>/dev/null || :
	fi

	if use dvdnav && use dvd; then
		ewarn "'dvdnav' support in MPlayer is known to be buggy, and will"
		ewarn "break if you are using it in GUI mode.  It is only"
		ewarn "included because some DVDs will only play with this feature."
		ewarn "If using it for playback only (and not menu navigation),"
		ewarn "specify the track # with your options."
		ewarn "mplayer dvdnav://1"
	fi
}

pkg_postrm() {

	# Cleanup stale symlinks
	if [ -L ${ROOT}/usr/share/mplayer/font -a \
		 ! -e ${ROOT}/usr/share/mplayer/font ]
	then
		rm -f ${ROOT}/usr/share/mplayer/font
	fi

	if [ -L ${ROOT}/usr/share/mplayer/subfont.ttf -a \
		 ! -e ${ROOT}/usr/share/mplayer/subfont.ttf ]
	then
		rm -f ${ROOT}/usr/share/mplayer/subfont.ttf
	fi
}
