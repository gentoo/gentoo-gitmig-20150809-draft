# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer/mplayer-0.90.ebuild,v 1.3 2003/04/20 08:40:04 seemant Exp $

IUSE="dga oss jpeg 3dfx sse matrox sdl X svga ggi oggvorbis 3dnow aalib gnome xv opengl truetype dvd gtk gif esd fbcon encode alsa directfb arts dvb"

inherit eutils

# NOTE to myself:  Test this thing with and without dvd/gtk+ support,
#                  as it seems the mplayer guys dont really care to
#                  make it work without dvd support.

# Handle PREversions as well
MY_PV="${PV/_/}"
S="${WORKDIR}/MPlayer-${MY_PV}"
# Only install Skin if GUI should be build (gtk as USE flag)
SRC_URI="http://www2.mplayerhq.hu/MPlayer/releases/MPlayer-${MY_PV}.tar.bz2
	http://mplayerhq.hu/MPlayer/releases/MPlayer-${MY_PV}.tar.bz2
	http://mplayerhq.hu/MPlayer/releases/fonts/font-arial-iso-8859-1.tar.bz2
	http://mplayerhq.hu/MPlayer/releases/fonts/font-arial-iso-8859-2.tar.bz2
	gtk? ( mirror://gentoo/distfiles/default-skin-0.1.tar.bz2 )"
#	 This is to get the digest problem fixed.
#	 gtk? ( ftp://mplayerhq.hu/MPlayer/Skin/default.tar.bz2 )"
DESCRIPTION="Media Player for Linux"
HOMEPAGE="http://www.mplayerhq.hu/"

# 'encode' in USE for MEncoder.
# If 'dvd' in USE, only DEPEND on libdvdnav, as
# we use libdvdkit that comes with.
RDEPEND="ppc? ( >=media-libs/xvid-0.9.0 )
	x86? ( >=media-libs/xvid-0.9.0
	       >=media-libs/divx4linux-20020418
	       >=media-libs/win32codecs-0.60 )
	gtk? ( !gtk2 ( =x11-libs/gtk+-1.2*
	               =dev-libs/glib-1.2* )
	       media-libs/libpng
	       >=x11-base/xfree-4.2.1-r2 )
	gtk2? ( >=x11-libs/gtk+-2.0.6
	        >=dev-libs/glib-2.0.6 )
	jpeg? ( media-libs/jpeg )
	gif? ( media-libs/giflib
	       media-libs/libungif )
	truetype? ( >=media-libs/freetype-2.1 )
	esd? ( media-sound/esound )
	ggi? ( media-libs/libggi )
	sdl? ( media-libs/libsdl )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	nas? ( media-libs/nas )
	svga? ( media-libs/svgalib )
	encode? ( media-sound/lame
	          >=media-libs/libdv-0.9.5 )
	xmms? ( media-sound/xmms )
	opengl? ( virtual/opengl )
	directfb? ( dev-libs/DirectFB )
	oggvorbis? ( media-libs/libvorbis )
	nls? ( sys-devel/gettext )
	media-sound/cdparanoia
	media-libs/faad2
	>=sys-apps/portage-2.0.36"
#	dvd? ( media-libs/libdvdnav )
# Hardcode paranoia support for now, as there is no
# related USE flag.

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	app-arch/unzip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"


src_unpack() {

	unpack MPlayer-${MY_PV}.tar.bz2

	use truetype || \
		unpack font-arial-iso-8859-1.tar.bz2 font-arial-iso-8859-1.tar.bz2

	# Fix bug with the default Skin
	if [ -n "`use gtk`" ]
	then
		unpack default-skin-0.1.tar.bz2
		cd ${WORKDIR}/default
		epatch ${FILESDIR}/default-skin.diff
	fi

	cd ${S}; epatch ${FILESDIR}/${PN}-0.90_rc4-gtk2.patch

	if [ -n "`use ppc`" ]
	then
		# Fix mplayer to detect detect/use altivec on benh kernels,
		# bug #18511.
		cd ${S}; epatch ${FILESDIR}/${P}-ppc-benh.patch
	fi
}

src_compile() {

	use matrox && check_KV

	local myconf=""

	use 3dnow \
		|| myconf="${myconf} --disable-3dnow --disable-3dnowex"

	use sse \
		|| myconf="${myconf} --disable-sse --disable-sse2"

	# Only disable MMX if 3DNOW or SSE is not in USE
	use mmx || use 3dnow || use sse \
		|| myconf="${myconf} --disable-mmx --disable-mmx2"

	# Only disable X if gtk is not in USE
	use X || use gtk \
		|| myconf="${myconf} --disable-gui --disable-x11 --disable-xv \
		                     --disable-xmga --disable-png"

	use jpeg \
		|| myconf="${myconf} --disable-jpeg"

	use gif \
		|| myconf="${myconf} --disable-gif"

	( use matrox && use X ) \
		&& myconf="${myconf} --enable-xmga" \
		|| myconf="${myconf} --disable-xmga"

	use gtk \
		&& myconf="${myconf} --enable-gui --enable-x11 \
		                     --enable-xv --enable-vm --enable-png"

	( use gtk && use gtk2 ) \
		&& myconf="${myconf} --enable-gtk2"

	use truetype \
		&& myconf="${myconf} --enable-freetype" \
		|| myconf="${myconf} --disable-freetype"

	use oss \
		|| myconf="${myconf} --disable-ossaudio"

	use opengl \
		|| myconf="${myconf} --disable-gl"

	use sdl \
		|| myconf="${myconf} --disable-sdl"

	use ggi \
		|| myconf="${myconf} --disable-ggi"

	use svga \
		|| myconf="${myconf} --disable-svga"

	use directfb \
		|| myconf="${myconf} --disable-directfb"

	use fbcon \
		|| myconf="${myconf} --disable-fbdev"

	use esd \
		|| myconf="${myconf} --disable-esd"

	use alsa \
		|| myconf="${myconf} --disable-alsa"

	use arts \
		|| myconf="${myconf} --disable-arts"

	use nas \
		|| myconf="${myconf} --disable-nas"

	use oggvorbis \
		|| myconf="${myconf} --disable-vorbis"

	use encode \
		&& myconf="${myconf} --enable-mencoder --enable-tv" \
		|| myconf="${myconf} --disable-mencoder"

	use dvd \
		&& myconf="${myconf} --enable-mpdvdkit --disable-dvdnav" \
		|| myconf="${myconf} --disable-mpdvdkit --disable-dvdread \
		                     --disable-css --disable-dvdnav"
	# Disable dvdnav support as its not considered to be functional anyhow

	use xmms \
		&& myconf="${myconf} --enable-xmms"

	use matrox \
		&& myconf="${myconf} --enable-mga" \
		|| myconf="${myconf} --disable-mga"

	use 3dfx \
		&& myconf="${myconf} --enable-3dfx --enable-tdfxfb"

	use dvb \
		&& myconf="${myconf} --enable-dvb" \
		|| myconf="${myconf} --disable-dvb"

	use nls \
		&& myconf="${myconf} --enable-i18n" \
		|| myconf="${myconf} --disable-i18n"

	if [ -d /opt/RealPlayer9/Real/Codecs ]
	then
		einfo "Setting REALLIBDIR to /opt/RealPlayer9/Real/Codecs..."
		REALLIBDIR="/opt/RealPlayer9/Real/Codecs"
	elif [ -d /opt/RealPlayer8/Codecs ]
	then
		einfo "Setting REALLIBDIR to /opt/RealPlayer8/Codecs..."
		REALLIBDIR="/opt/RealPlayer8/Codecs"
	else
		REALLIBDIR="/usr/lib/real"
	fi

	if has_version media-plugins/live
	then
		einfo "Enabling LIVE.COM Streaming Media..."
		myconf="${myconf} --enable-live"
	fi


	# For lirc support as the auto-detect doesn't seem to work
	if [ -f /usr/include/lirc/lirc_client.h ]
	then
		einfo "Enabling lirc support..."
		myconf="${myconf} --enable-lirc"
	else
		myconf="${myconf} --disable-lirc"
	fi

	if [ -e /dev/.devfsd ]
	then
		myconf="${myconf} --enable-linux-devfs"
	fi

	# Crashes on start when compiled with most optimizations.
	# The code have CPU detection code now, with CPU specific
	# optimizations, so extra should not be needed and is not
	# recommended by the authors
	unset CFLAGS CXXFLAGS
	./configure --prefix=/usr \
		--datadir=/usr/share/mplayer \
		--confdir=/usr/share/mplayer \
		--disable-runtime-cpudetection \
		--enable-largefiles \
		--enable-menu \
		--enable-dynamic-plugins \
		--enable-real \
		--enable-faad \
		--with-reallibdir=${REALLIBDIR} \
		--with-x11incdir=/usr/X11R6/include \
		${myconf} || die
	# Breaks with gcc-2.95.3, bug #14479
	# --enable-shared-pp \

	# emake borks on fast boxes - Azarah (07 Aug 2002)
	make all || die

	if [ -n "`use matrox`" ]
	then
		cd drivers
		make all || die
	fi
}

src_install() {

	make prefix=${D}/usr \
	     BINDIR=${D}/usr/bin \
		 LIBDIR=${D}/usr/lib \
	     CONFDIR=${D}/usr/share/mplayer \
	     DATADIR=${D}/usr/share/mplayer \
	     MANDIR=${D}/usr/share/man \
	     install || die

	# Some stuff like transcode can use this one.
	if [ -f ${S}/postproc/libpostproc.a ]
	then
		dolib ${S}/postproc/libpostproc.a

		if [ ! -f ${D}/usr/include/postproc/postprocess.h ]
		then
			insinto /usr/include/postproc
			doins ${S}/postproc/postprocess.h
		fi
	fi

	# Install the documentation
	dohtml -r ${S}/DOCS/*

	dodoc AUTHORS ChangeLog README

	# Install the default Skin and Gnome menu entry
	if [ -n "`use gtk`" ]
	then
		insinto /usr/share/mplayer/Skin/default
		doins ${WORKDIR}/default/*
		# Permissions is fried by default
		chmod a+rx ${D}/usr/share/mplayer/Skin/default/
		chmod a+r ${D}/usr/share/mplayer/Skin/default/*

		# Fix the symlink
		rm -rf ${D}/usr/bin/gmplayer
		dosym /usr/bin/mplayer /usr/bin/gmplayer
	fi

	if [ -n "`use gnome`" ]
	then
		insinto /usr/share/pixmaps
		newins ${S}/Gui/mplayer/pixmaps/logo.xpm mplayer.xpm
		insinto /usr/share/gnome/apps/Multimedia
		doins ${FILESDIR}/mplayer.desktop
	fi

	# Install the font used by OSD and the GUI
	if [ -z "`use truetype`" ]
	then
		dodir /usr/share/mplayer/fonts
		cp -a ${WORKDIR}/font-arial* ${D}/usr/share/mplayer/fonts
		rm -rf ${D}/usr/share/mplayer/font
		dosym fonts/font-arial-14-iso-8859-1 /usr/share/mplayer/font
	elif [ -f /usr/X11R6/lib/X11/fonts/truetype/arial.ttf ]
	then
		# For freetype we need a real truetype font in place ...
		dosym ../../X11R6/lib/X11/fonts/truetype/arial.ttf \
			/usr/share/mplayer/subfont.ttf
	fi
	if [ -n "`use truetype`" ]
	then
		rm -rf ${D}/usr/share/mplayer/font
	fi

	# This tries setting up mplayer.conf automagically
	local video="" audio="sdl"
	if [ -n "`use X`" ]
	then
		[ -z "${video}" ] && use sdl && video="sdl"
		[ -z "${video}" ] && use xv && video="xv"
		[ -z "${video}" ] && use opengl && video="gl"
		[ -z "${video}" ] && use ggi && video="ggi"
		[ -z "${video}" ] && use dga && video="dga"
		[ -z "${video}" ] && video="x11"
	else
		[ -z "${video}" ] && use fbcon && video="fbdev"
		[ -z "${video}" ] && use svga && video="svga"
		[ -z "${video}" ] && use aalib && video="aa"
		[ -z "${video}" ] && video="vesa"
	fi

	if [ -n "`use sdl`" ]
	then
		audio="sdl"
	elif [ -n "`use alsa`" ]
	then
		if [ -e /usr/lib/libasound.so.2 ]
		then
			audio="alsa9"
		else
			audio="alsa5"
		fi
	elif [ -n "`use oss`" ]
	then
		audio="oss"
	fi

	# Note to myself:  do not change " into '
	sed -e "s/^# vo=xv/vo=${video}/" \
	    -e "s/^# ao=oss/ao=${audio}/" \
	    -e 's/include =/#include =/' \
	    ${S}/etc/example.conf > ${T}/mplayer.conf

	insinto /etc
	doins ${T}/mplayer.conf
	dosym ../../../etc/mplayer.conf /usr/share/mplayer/mplayer.conf

	insinto /usr/share/mplayer
	doins ${S}/etc/codecs.conf
	doins ${S}/etc/input.conf
	doins ${S}/etc/menu.conf

	if [ -n "`use matrox`" ]
	then
		check_KV
		insinto /lib/modules/${KV}/kernel/drivers/char
		doins ${S}/drivers/mga_vid.o
	fi
}

pkg_postinst() {

	if [ -n "`use truetype`" ]
	then
		einfo "Please note that with the new freetype support you need to"
		einfo "copy a truetype (.ttf) font to ~/.mplayer/subfont.ttf"
	fi

	if [ -n "`use ppc`" ]
	then
		echo
		einfo "When you see only GREEN salad on your G4 while playing"
		einfo "a DivX, you should recompile _without_ altivec enabled."
		einfo "Furher information: http://bugs.gentoo.org/show_bug.cgi?id=18511"
		echo
		einfo "If everything functions fine with watching DivX and"
		einfo "altivec enabled, please drop a comment on the mentioned bug!"
	fi

	depmod -a &>/dev/null || :
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

