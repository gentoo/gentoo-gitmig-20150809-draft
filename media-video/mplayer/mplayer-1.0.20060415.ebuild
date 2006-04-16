# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer/mplayer-1.0.20060415.ebuild,v 1.5 2006/04/16 23:21:55 lu_zero Exp $

inherit eutils flag-o-matic

RESTRICT="nostrip"
IUSE="3dfx 3dnow 3dnowext aac aalib alsa altivec arts bidi bl bindist
cpudetection custom-cflags debug dga doc dts dvb cdparanoia directfb dvd dv
dvdread edl encode esd fbcon gif ggi gtk i8x0 ipv6 jack joystick jpeg libcaca
lirc live livecd lzo mad matroska matrox mmx mmxext musepack nas nvidia
unicode vorbis opengl openal oss png real rtc samba sdl sse sse2 svga tga
theora truetype v4l v4l2 win32codecs X x264 xanim xinerama xmms xv xvid xvmc"
# openal
BLUV=1.4
SVGV=1.9.17

# Handle PREversions as well
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-iso-8859-1.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-iso-8859-2.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-cp1250.tar.bz2
	svga? ( http://mplayerhq.hu/~alex/svgalib_helper-${SVGV}-mplayer.tar.bz2 )
	gtk? ( mirror://mplayer/Skin/Blue-${BLUV}.tar.bz2 )"

# Only install Skin if GUI should be build (gtk as USE flag)
DESCRIPTION="Media Player for Linux (snapshot)"
HOMEPAGE="http://www.mplayerhq.hu/"

# 'encode' in USE for MEncoder.
RDEPEND="xvid? ( >=media-libs/xvid-0.9.0 )
	win32codecs? ( >=media-libs/win32codecs-20040916 )
	x86? ( real? ( >=media-video/realplayer-10.0.3 ) )
	aalib? ( media-libs/aalib )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	openal? ( media-libs/openal )
	bidi? ( dev-libs/fribidi )
	cdparanoia? ( media-sound/cdparanoia )
	dga? ( || ( x11-libs/libXxf86dga virtual/x11 ) )
	directfb? ( dev-libs/DirectFB )
	dts? ( media-libs/libdts )
	dvb? ( media-tv/linuxtv-dvb-headers )
	dvd? ( dvdread? ( media-libs/libdvdread ) )
	encode? (
		media-sound/lame
		dv? ( >=media-libs/libdv-0.9.5 )
		x264? ( >=media-libs/x264-svn-20060409 )
		)
	esd? ( media-sound/esound )
	gif? ( media-libs/giflib )
	ggi? ( media-libs/libggi )
	gtk? (
		media-libs/libpng
		|| ( ( x11-libs/libXxf86vm
				x11-libs/libXext
				x11-libs/libXi
			)
			virtual/x11
		)
		=x11-libs/gtk+-2*
		=dev-libs/glib-2*
		)
	jpeg? ( media-libs/jpeg )
	libcaca? ( media-libs/libcaca )
	lirc? ( app-misc/lirc )
	lzo? ( =dev-libs/lzo-1* )
	mad? ( media-libs/libmad )
	musepack? ( >=media-libs/libmpcdec-1.2.2 )
	nas? ( media-libs/nas )
	nls? ( virtual/libintl )
	opengl? ( virtual/opengl )
	png? ( media-libs/libpng )
	samba? ( >=net-fs/samba-2.2.8a )
	sdl? ( media-libs/libsdl )
	svga? ( media-libs/svgalib )
	theora? ( media-libs/libtheora )
	live? ( >=media-plugins/live-2004.07.20 )
	truetype? ( >=media-libs/freetype-2.1 )
	xinerama? ( || ( ( x11-libs/libXinerama
				x11-libs/libXxf86vm
				x11-libs/libXext
			)
			virtual/x11
		)
	)
	xmms? ( media-sound/xmms )
	xanim? ( >=media-video/xanim-2.80.1-r4 )
	sys-libs/ncurses
	xv? ( || ( ( x11-libs/libXv
				x11-libs/libXxf86vm
				x11-libs/libXext
			)
			virtual/x11
		)
	)
	xvmc? ( || ( x11-libs/libXvMC virtual/x11 ) )
	X? ( || ( ( x11-libs/libXxf86vm
				x11-libs/libXext
			)
			virtual/x11
		)
	)"

DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( >=app-text/docbook-sgml-dtd-4.1.2
		   app-text/docbook-xml-dtd
		   >=app-text/docbook-xml-simple-dtd-1.50.0
		   dev-libs/libxslt
		   )
	nls? ( sys-devel/gettext )
	dga? ( || ( x11-proto/xf86dgaproto virtual/x11 ) )
	xinerama? ( || ( x11-proto/xineramaproto virtual/x11 ) )
	xv? ( || ( ( x11-proto/videoproto
				x11-proto/xf86vidmodeproto
			)
			virtual/x11
		)
	)
	gtk? ( || ( ( x11-proto/xextproto
				x11-proto/xf86vidmodeproto
			)
			virtual/x11
		)
	)
	X? ( || ( ( x11-proto/xextproto
				x11-proto/xf86vidmodeproto
			)
			virtual/x11
		)
	)"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 sparc ~x86"

pkg_setup() {
	if use real && use x86; then
		REALLIBDIR="/opt/RealPlayer/codecs"
	fi
}

src_unpack() {

	unpack ${P}.tar.bz2 \
		font-arial-iso-8859-1.tar.bz2 font-arial-iso-8859-2.tar.bz2 \
		font-arial-cp1250.tar.bz2

	use svga && unpack svgalib_helper-${SVGV}-mplayer.tar.bz2

	use gtk && unpack Blue-${BLUV}.tar.bz2

	cd ${S}

	# Fix hppa compilation
	[ "${ARCH}" = "hppa" ] && sed -i -e "s/-O4/-O1/" "${S}/configure"

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
	use sparc && sed -i 's:#define __KERNEL__::' osdep/kerneltwosix.h

	# minor fix
	sed -i -e "s:-O4:-O4 -D__STDC_LIMIT_MACROS:" configure

	epatch ${FILESDIR}/gcc-3-register_allocation.patch

}

linguas_warn() {
	ewarn "Language ${LANG[0]} or ${LANG_CC} not avaliable"
	ewarn "Language set to English"
	ewarn "If this is a mistake, please set the"
	ewarn "First LINGUAS language to one of the following"
	ewarn
	ewarn "bg - Bulgarian"
	ewarn "cs - Czech"
	ewarn "de - German"
	ewarn "dk - Danish"
	ewarn "el - Greek"
	ewarn "en - English"
	ewarn "es - Spanish"
	ewarn "fr - French"
	ewarn "hu - Hungarian"
	ewarn "ja - Japanese"
	ewarn "ko - Korean"
	ewarn "mk - FYRO Macedonian"
	ewarn "nl - Dutch"
	ewarn "no - Norwegian"
	ewarn "pl - Polish"
	ewarn "pt_BR - Portuguese - Brazil"
	ewarn "ro - Romanian"
	ewarn "ru - Russian"
	ewarn "sk - Slovak"
	ewarn "tr - Turkish"
	ewarn "uk - Ukranian"
	ewarn "zh_CN - Chinese - China"
	ewarn "zh_TW - Chinese - Taiwan"
	export LINGUAS="en ${LINGUAS}"
}

src_compile() {

	# have fun with LINGUAS variable
	if [[ -n $LINGUAS ]]
	then
		# LINGUAS has stuff in it, start the logic
		LANG=( $LINGUAS )
		if [ -e ${S}/help/help_mp-${LANG[0]}.h ]
		then
			einfo "Setting MPlayer messages to language: ${LANG[0]}"
		else
			LANG_CC=${LANG[0]}
			if [ ${#LANG_CC} -ge 2 ]
			then
				LANG_CC=${LANG_CC:0:2}
				if [ -e ${S}/help/help_mp-${LANG_CC}.h ]
				then
					einfo "Setting MPlayer messages to language ${LANG_CC}"
					export LINGUAS="${LANG_CC} ${LINGUAS}"
				else
					linguas_warn
				fi
			else
				linguas_warn
			fi
		fi
	else
		# sending blank LINGUAS, make it default to en
		einfo "No LINGUAS given, defaulting to English"
		export LINGUAS="en ${LINGUAS}"
	fi




	local myconf="--disable-external-faad --disable-tv-bsdbt848"
	myconf="--disable-external-vidix"
	################
	#Optional features#
	###############
	if use cpudetection || use livecd || use bindist
	then
	myconf="${myconf} --enable-runtime-cpudetection"
	fi

	myconf="${myconf} $(use_enable bidi fribidi)"
	if use unicode; then
		myconf="${myconf} --charset=utf8"
	fi
	myconf="${myconf} $(use_enable cdparanoia)"
	if use dvd; then
		myconf="${myconf} $(use_enable dvdread) $(use_enable !dvdread mpdvdkit)"
	else
		myconf="${myconf} --disable-dvdread --disable-mpdvdkit"
	fi
	myconf="${myconf} $(use_enable edl)"

	if use encode ; then
		myconf="${myconf} --enable-mencoder $(use_enable dv libdv) \
											$(use_enable x264)"
	else
		myconf="${myconf} --disable-mencoder --disable-libdv --disable-x264"
	fi

	myconf="${myconf} $(use_enable gtk gui)"

	if use !gtk && use !X && use !xv && use !xinerama; then
		myconf="${myconf} --disable-gui --disable-x11 --disable-xv --disable-xmga --disable-xinerama --disable-vm --disable-xvmc"
	else
		#note we ain't touching --enable-vm.  That should be locked down in the future.
		myconf="${myconf} --enable-x11 $(use_enable xinerama) $(use_enable xv) $(use_enable gtk gui)"
	fi

	# this looks like a hack, but the
	# --enable-dga needs a paramter, but there's no surefire
	# way to tell what it is.. so I'm letting MPlayer decide
	# the enable part
	if ! use dga && ! use 3dfx ; then
		myconf="${myconf} --disable-dga"
	fi
	# disable png *only* if gtk && png aren't on
	if use png || use gtk; then
		myconf="${myconf} --enable-png"
	else
		myconf="${myconf} --disable-png"
	fi
	myconf="${myconf} $(use_enable ipv6 inet6)"
	myconf="${myconf} $(use_enable joystick)"
	myconf="${myconf} $(use_enable lirc)"
	myconf="${myconf} $(use_enable live)"
	myconf="${myconf} $(use_enable rtc)"
	myconf="${myconf} $(use_enable samba smb)"
	myconf="${myconf} $(use_enable truetype freetype)"
	myconf="${myconf} $(use_enable v4l tv-v4l)"
	myconf="${myconf} $(use_enable v4l2 tv-v4l2)"
	use jack || myconf="${myconf} --disable-jack"

	#########
	# Codecs #
	########
	myconf="${myconf} $(use_enable gif)"
	myconf="${myconf} $(use_enable jpeg)"
	#myconf="${myconf} $(use_enable ladspa)"
	myconf="${myconf} $(use_enable dts libdts)"
	myconf="${myconf} $(use_enable lzo liblzo)"
	myconf="${myconf} $(use_enable matroska internal-matroska)"
	myconf="${myconf} $(use_enable musepack)"
	myconf="${myconf} $(use_enable aac internal-faad)"
	myconf="${myconf} $(use_enable vorbis)"
	myconf="${myconf} $(use_enable theora)"
	myconf="${myconf} $(use_enable xmms)"
	myconf="${myconf} $(use_enable xvid)"
	use x86 && myconf="${myconf} $(use_enable real)"
	myconf="${myconf} $(use_enable win32codecs win32)"

	#############
	# Video Output #
	#############
	myconf="${myconf} $(use_enable 3dfx)"
	if use 3dfx; then
		myconf="${myconf} --enable-tdfxvid"
	else
		myconf="${myconf} --disable-tdfxvid"
	fi
	if use fbcon && use 3dfx; then
		myconf="${myconf} --enable-tdfxfb"
	else
		myconf="${myconf} --disable-tdfxfb"
	fi

	if use dvb ; then
		myconf="${myconf} --enable-dvbhead --with-dvbincdir=/usr/include"
	else
		myconf="${myconf} --disable-dvbhead"
	fi

	use aalib || myconf="${myconf} --disable-aa"
	myconf="${myconf} $(use_enable directfb)"
	myconf="${myconf} $(use_enable fbcon fbdev)"
	myconf="${myconf} $(use_enable ggi)"
	myconf="${myconf} $(use_enable libcaca caca)"
	if use matrox && use X; then
		myconf="${myconf} $(use_enable matrox xmga)"
	fi
	myconf="${myconf} $(use_enable matrox mga)"
	myconf="${myconf} $(use_enable opengl gl)"
	myconf="${myconf} $(use_enable sdl)"

	if use svga
	then
		myconf="${myconf} --enable-svga"
	else
		myconf="${myconf} --disable-svga --disable-internal-vidix"
	fi

	myconf="${myconf} $(use_enable tga)"

	( use xvmc && use nvidia ) \
		&& myconf="${myconf} --enable-xvmc --with-xvmclib=XvMCNVIDIA"

	( use xvmc && use i8x0 ) \
		&& myconf="${myconf} --enable-xvmc --with-xvmclib=I810XvMC"

	( use xvmc && use nvidia && use i8x0 ) \
		&& {
			eerror "Invalid combination of USE flags"
			eerror "When building support for xvmc, you may only"
			eerror "include support for one video card:"
			eerror "   nvidia, i8x0"
			eerror
			eerror "Emerge again with different USE flags"

			exit 1
		}

	( use xvmc && ! use nvidia && ! use i8x0 ) && {
		ewarn "You tried to build with xvmc support."
		ewarn "No supported graphics hardware was specified."
		ewarn
		ewarn "No xvmc support will be included."
		ewarn "Please one appropriate USE flag and re-emerge:"
		ewarn "   nvidia or i8x0"

		myconf="${myconf} --disable-xvmc"
	}

	#############
	# Audio Output #
	#############
	use alsa || myconf="${myconf} --disable-alsa"
	use arts || myconf="${myconf} --disable-arts"
	use esd || myconf="${myconf} --disable-esd"
	use mad || myconf="${myconf} --disable-mad"
	use nas || myconf="${myconf} --disable-nas"
	use openal || myconf="${myconf} --disable-openal"
	use oss || myconf="${myconf} --disable-ossaudio"

	#################
	# Advanced Options #
	#################
	# Platform specific flags, hardcoded on amd64 (see below)
	use x86 && myconf="${myconf} $(use_enable 3dnow)"
	use x86 && myconf="${myconf} $(use_enable 3dnowext 3dnowex)";
	use x86 && myconf="${myconf} $(use_enable sse)"
	use x86 && myconf="${myconf} $(use_enable sse2)"
	use x86 && myconf="${myconf} $(use_enable mmx)"
	use x86 && myconf="${myconf} $(use_enable mmxext mmx2)"
	myconf="${myconf} $(use_enable debug)"

	# mplayer now contains SIMD assembler code for amd64
	# AMD64 Team decided to hardenable SIMD assembler for all users
	# Danny van Dyk <kugelfang@gentoo.org> 2005/01/11
	if use amd64; then
		myconf="${myconf} --enable-3dnow --enable-3dnowex --enable-sse --enable-sse2 --enable-mmx --enable-mmx2"
	fi

	if use ppc64
	then
		myconf="${myconf} --disable-altivec"
	else
		myconf="${myconf} $(use_enable altivec)"
		use altivec && append-flags -maltivec -mabi=altivec
	fi


	if use xanim
	then
		myconf="${myconf} --with-xanimlibdir=/usr/lib/xanim/mods"
	fi

	if [ -e /dev/.devfsd ]
	then
		myconf="${myconf} --enable-linux-devfs"
	fi

	use xmms && myconf="${myconf} --with-xmmslibdir=/usr/$(get_libdir)"

	use live && myconf="${myconf} --with-livelibdir=/usr/$(get_libdir)/live"

	# support for blinkenlights
	use bl && myconf="${myconf} --enable-bl"

	#leave this in place till the configure/compilation borkage is completely corrected back to pre4-r4 levels.
	# it's intended for debugging so we can get the options we configure mplayer w/, rather then hunt about.
	# it *will* be removed asap; in the meantime, doesn't hurt anything.
	echo "${myconf}" > ${T}/configure-options

	if use custom-cflags
	then
	# let's play the filtration game!  MPlayer hates on all!
	strip-flags
	# ugly optimizations cause MPlayer to cry on x86 systems!
		if use x86 ; then
			replace-flags -O0 -O2
			replace-flags -O3 -O2
			filter-flags -fPIC -fPIE
		fi
	append-flags -D__STDC_LIMIT_MACROS
	else
	unset CFLAGS CXXFLAGS
	fi

	CFLAGS="$CFLAGS" ./configure \
		--prefix=/usr \
		--confdir=/usr/share/mplayer \
		--datadir=/usr/share/mplayer \
		--enable-largefiles \
		--enable-menu \
		--enable-network --enable-ftp \
		--with-reallibdir=${REALLIBDIR} \
		--with-x11incdir=/usr/X11R6/include \
		--disable-external-faad \
		${myconf} || die

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
		dodir /usr/share/mplayer/Skin
		cp -r ${WORKDIR}/Blue ${D}/usr/share/mplayer/Skin/default || die

		# Fix the symlink
		rm -rf ${D}/usr/bin/gmplayer
		dosym mplayer /usr/bin/gmplayer

		insinto /usr/share/pixmaps
		newins ${S}/Gui/mplayer/pixmaps/logo.xpm mplayer.xpm
		insinto /usr/share/applications
		doins ${FILESDIR}/mplayer.desktop
	fi

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

	insinto /etc
	newins ${S}/etc/example.conf mplayer.conf
	dosed -e 's/include =/#include =/' /etc/mplayer.conf
	dosed -e 's/fs=yes/fs=no/' /etc/mplayer.conf
	dosym ../../../etc/mplayer.conf /usr/share/mplayer/mplayer.conf

	#mv the midentify script to /usr/bin for emovix.
	cp ${D}/usr/share/doc/${PF}/TOOLS/midentify ${D}/usr/bin
	chmod a+x ${D}/usr/bin/midentify

	insinto /usr/share/mplayer
	doins ${S}/etc/codecs.conf
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

	if use matrox; then
		depmod -a &>/dev/null || :
	fi

	if use alsa ; then
		einfo "For those using alsa, please note the ao driver name is no longer"
		einfo "alsa9x or alsa1x.  It is now just 'alsa' (omit quotes)."
		einfo "The syntax for optional drivers has also changed.  For example"
		einfo "if you use a dmix driver called 'dmixer,' use"
		einfo "ao=alsa:device=dmixer instead of ao=alsa:dmixer"
		einfo "Some users may not need to specify the extra driver with the ao="
		einfo "command."
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

