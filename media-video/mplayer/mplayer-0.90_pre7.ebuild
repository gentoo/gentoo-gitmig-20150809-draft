# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer/mplayer-0.90_pre7.ebuild,v 1.1 2002/09/15 20:49:57 azarah Exp $

# NOTE to myself:  Test this thing with and without dvd/gtk+ support,
#                  as it seems the mplayer guys dont really care to
#                  make it work without dvd support.

# Handle PREversions as well
MY_PV=${PV/_/}
S="${WORKDIR}/MPlayer-${MY_PV}"
# Only install Skin if GUI should be build (gtk as USE flag)
SRC_URI="ftp://mplayerhq.hu/MPlayer/releases/MPlayer-${MY_PV}.tar.bz2
	ftp://mplayerhq.hu/MPlayer/releases/mp-arial-iso-8859-1.zip
	ftp://mplayerhq.hu/MPlayer/releases/mp-arial-iso-8859-2.zip
	gtk? ( mirror://gentoo/distfiles/default-skin-0.1.tar.bz2 )"
#	 This is to get the digest problem fixed.
#	 gtk? ( ftp://mplayerhq.hu/MPlayer/Skin/default.tar.bz2 )"
DESCRIPTION="Media Player for Linux"
HOMEPAGE="http://www.mplayerhq.hu/"

# 'encode' in USE for MEncoder.
# If 'dvd' in USE, only DEPEND on libdvdnav, as
# we use libdvdkit that comes with.
RDEPEND="x86? ( >=media-libs/divx4linux-20020418 )
	x86? ( >=media-libs/win32codecs-0.60 )
	dvd? ( media-libs/libdvdnav )
	gtk? ( =x11-libs/gtk+-1.2*
	       media-libs/libpng ) 
	jpeg? ( media-libs/jpeg )
	gif? ( media-libs/giflib
	       media-libs/libungif )
	truetype? ( >=media-libs/freetype-2.1 )
	esd? ( media-sound/esound )
	ggi? ( media-libs/libggi )
	sdl? ( media-libs/libsdl )
	alsa? ( media-libs/alsa-lib )
	svga? ( media-libs/svgalib )
	encode? ( media-sound/lame 
	          >=media-libs/libdv-0.9.5 )
	opengl? ( virtual/opengl )
	directfb? ( dev-libs/DirectFB )
	oggvorbis? ( media-libs/libvorbis )
	>=sys-apps/portage-2.0.36"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	app-arch/unzip"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86 ppc"


src_unpack() {

	unpack MPlayer-${MY_PV}.tar.bz2

	use truetype || unpack mp-arial-iso-8859-1.zip mp-arial-iso-8859-2.zip

	# Fix bug with the default Skin
	if [ -n "`use gtk`" ]
	then
		unpack default-skin-0.1.tar.bz2
		cd ${WORKDIR}/default
		patch < ${FILESDIR}/default-skin.diff || die "gtk patch failed"
	fi
}

src_compile() {

	use matrox && check_KV
        
	local myconf=""

	use 3dnow \
		|| myconf="${myconf} --disable-3dnow --disable-3dnowex"

	use sse	\
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

	use matrox && use X \
		&& myconf="${myconf} --enable-xmga"

	use gtk \
		&& myconf="${myconf} --enable-gui --enable-x11 \
		                     --enable-xv --enable-vm --enable-png"

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

	use alsa \
		|| myconf="${myconf} --disable-alsa"

	use oggvorbis \
		|| myconf="${myconf} --disable-vorbis"

	use encode \
		&& myconf="${myconf} --enable-mencoder --enable-tv" \
		|| myconf="${myconf} --disable-mencoder"

	use dvd \
		&& myconf="${myconf} --enable-mpdvdkit --enable-dvdnav" \
		|| myconf="${myconf} --disable-mpdvdkit --disable-dvdread \
		                     --disable-css --disable-dvdnav"

	use matrox \
		&& myconf="${myconf} --enable-mga" \
		|| myconf="${myconf} --disable-mga"

	use 3dfx \
		&& myconf="${myconf} --enable-3dfx --enable-tdfxfb"

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
		--enable-linux-devfs \
		${myconf} || die

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
		insinto /usr/include
		doins ${S}/postproc/postprocess.h
	fi

	# Install the documentation
	dohtml -r ${S}/DOCS/*

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
		newins ${S}/Gui/mplayer/pixmaps/icon.xpm mplayer.xpm
		insinto /usr/share/gnome/apps/Multimedia
		doins ${FILESDIR}/mplayer.desktop
	fi

	# Install the font used by OSD and the GUI
	if [ -z "`use truetype`" ]
	then
		dodir /usr/share/mplayer/fonts
		cp -a ${WORKDIR}/iso-8859-[12]/ ${D}/usr/share/mplayer/fonts
		rm -rf ${D}/usr/share/mplayer/font
		dosym /usr/share/mplayer/fonts/iso-8859-1/arial-14/ /usr/share/mplayer/font
	elif [ -f /usr/X11R6/lib/X11/fonts/truetype/arial.ttf ]
	then
		# For freetype we need a real truetype font in place ...
		dosym /usr/X11R6/lib/X11/fonts/truetype/arial.ttf \
			/usr/share/mplayer/subfont.ttf
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
	dosym /etc/mplayer.conf /usr/share/mplayer/mplayer.conf
	
	insinto /usr/share/mplayer
	doins ${S}/etc/codecs.conf

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
		einfo
		einfo "***************************************************************"
		einfo " Please note that with the new freetype support you need to"
		einfo " copy a truetype (.ttf) font to ~/.mplayer/subfont.ttf"
		einfo "***************************************************************"
		einfo
	fi

	depmod -a &>/dev/null || :
}

