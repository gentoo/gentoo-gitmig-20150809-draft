# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer/mplayer-0.90_pre6-r3.ebuild,v 1.7 2002/09/16 15:03:46 doctomoe Exp $

# NOTE to myself:  Test this thing with and without dvd/gtk+ support,
#                  as it seems the mplayer guys dont really care to
#                  make it work without dvd support.

# Handle PREversions as well
MY_PV=${PV/_/}
S="${WORKDIR}/MPlayer-${MY_PV}"
# Only install Skin if GUI should be build (gtk as USE flag)
SRC_URI="ftp://mplayerhq.hu/MPlayer/releases/MPlayer-${MY_PV}.tar.bz2
	 ftp://mplayerhq.hu/MPlayer/releases/mp-arial-iso-8859-1.zip
	 gtk? ( http://www.ibiblio.org/gentoo/distfiles/default-skin-0.1.tar.bz2 )"
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
	>=sys-apps/portage-1.9.10"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	app-arch/unzip"

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86"


src_unpack() {

	unpack MPlayer-${MY_PV}.tar.bz2 mp-arial-iso-8859-1.zip

	# Fix bug with the default Skin
	use gtk && ( \
		unpack default-skin-0.1.tar.bz2
		cd ${WORKDIR}/default
		patch < ${FILESDIR}/default-skin.diff || die "gtk patch failed"
	)

	cd ${S}
	# Patch to enable use of libdvdnav-0.1.3
	# Azarah (12 Aug 2002)
	patch -p1 < ${FILESDIR}/${P}-libdvdnav-0.1.3.patch || die
	# Fixes some compile problems, thanks to Gwenn Gueguen
	patch -p0 < ${FILESDIR}/mplayer-0.90_pre5-widget.patch || die
	# Fixes include problem - Azarah (10 Jun 2002)
	# Update for pre6 - Azarah (07 Aug 2002)
	patch -p1 < ${FILESDIR}/${P}-stream-include.patch || die
	# Fixes install location for vidix drivers, thanks to Mezei Zoltan.
	patch -p1 < ${FILESDIR}/mplayer-0.90_pre5-vidix-destpath.patch || die
	# Fix missing subtitles for some regions (4), bug #3679, thanks
	# to Bernardo Silva
	patch -p1 < ${FILESDIR}/mplayer-0.90_pre5-spudec.c.patch || die
	# Fixes intermittant problems where vidix drivers do not get build,
	# and causes the install to fail - Azarah (06 Aug 2002)
	patch -p1 < ${FILESDIR}/${P}-vidix-fail-install.patch || die
	# Fixes compile problems if dvd support not enabled.
	# Azarah (07 Aug 2002)
	patch -p1 < ${FILESDIR}/${P}-no-dvd.patch || die
}

src_compile() {

	if use matrox; then
	        check_KV
	fi
        
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

	use matrox && use X \
		&& myconf="${myconf} --enable-xmga"

	use gtk \
		&& myconf="${myconf} --enable-gui --enable-x11 --enable-xv --enable-png"

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

# Currently libdvdnav do not compile on gcc-3.1.1
#	use dvd \
#		&& myconf="${myconf} --enable-dvdread --enable-dvdnav" \
#		|| myconf="${myconf} --disable-mpdvdkit --disable-dvdread \
#       		             --disable-css --disable-dvdnav"
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
		--disable-runtime-cpudetection \
		--enable-largefiles \
		--enable-linux-devfs \
		${myconf} || die

	# emake borks on fast boxes - Azarah (07 Aug 2002)
	make all || die
	
	use matrox && ( \
		cd drivers 
		make all || die
	)
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
	if [ -f ${S}/postproc/libpostproc.a ] ; then
		dolib ${S}/postproc/libpostproc.a
		insinto /usr/include
		doins ${S}/postproc/postprocess.h
	fi

	# Install the documentation
	dohtml -r ${S}/DOCS/*

	# Install the default Skin and Gnome menu entry
	use gtk && ( \
		insinto /usr/share/mplayer/Skin/default
		doins ${WORKDIR}/default/*
		# Permissions is fried by default
		chmod a+rx ${D}/usr/share/mplayer/Skin/default/
		chmod a+r ${D}/usr/share/mplayer/Skin/default/*

		# Fix the symlink
		rm -rf ${D}/usr/bin/gmplayer
		dosym /usr/bin/mplayer /usr/bin/gmplayer
	)

	use gnome && ( \
		insinto /usr/share/pixmaps
		newins ${S}/Gui/mplayer/pixmaps/icon.xpm mplayer.xpm
		insinto /usr/share/gnome/apps/Multimedia
		doins ${FILESDIR}/mplayer.desktop
	)

	# Install the font used by OSD and the GUI
	dodir /usr/share/mplayer/fonts
	cp -a ${WORKDIR}/iso-8859-1/ ${D}/usr/share/mplayer/fonts
	rm -rf ${D}/usr/share/mplayer/font
	dosym /usr/share/mplayer/fonts/iso-8859-1/arial-14/ /usr/share/mplayer/font

	# This tries setting up mplayer.conf automagically
	local video="sdl" audio="sdl"
	use X && (
		use gtk && video="xv" \
		|| use sdl && video="sdl" \
		|| use xv && video="xv" \
		|| use opengl && video="gl" \
		|| use ggi && video="ggi" \
		|| use dga && video="dga" \
		|| video="x11"
	) || (
		use fbcon && video="fbdev" \
		|| use svga && video="svga" \
		|| use aalib && video="aa"
	)

	use sdl && audio="sdl" \
	|| use alsa && (
		[ -e /usr/lib/libasound.so.2 ] && audio="alsa9" \
		|| audio="alsa5"
	) || use oss audio="oss" \
	
	# Note to myself:  do not change " into '
	sed -e "s/vo=xv/vo=${video}/" \
	    -e "s/ao=oss/ao=${audio}/" \
	    -e 's/include =/#include =/' \
	    ${S}/etc/example.conf > ${T}/mplayer.conf

	insinto /etc
	doins ${T}/mplayer.conf 
	
	insinto /usr/share/mplayer
	doins ${S}/etc/codecs.conf

	use matrox && ( \
		dodir /lib/modules/${KV}/kernel/drivers/char
		cp ${S}/drivers/mga_vid.o ${D}/lib/modules/${KV}/kernel/drivers/char
	)
}

pkg_postinst() {

	echo
	echo '######################################################################'
	echo '# MPlayer users that are going to use the GUI, please note the       #'
	echo '# following:                                                         #'
	echo '#                                                                    #'
	echo '#   The GUI works best with mplayer -vo xv -gui, but since there is  #'
	echo '#   no USE flag for XVideo, or for using the GUI, the autodetection  #'
	echo '#   process cannot detect this by default (SDL will be used rather). #'
	echo '#   So, if your setup supports XVideo (xvinfo should give output),   #'
	echo '#   maybe do something like:                                         #'
	echo '#                                                                    #'
	echo '#     echo "vo = xv" >~/.mplayer/config                              #'
	echo '#     echo "gui = 1" >>~/.mplayer/config                             #'
	echo '#                                                                    #'
	echo '#   after launching mplayer for the first time.                      #'
	echo '#                                                                    #'
	use gtk &>/dev/null \
		|| echo '# NB: the GUI needs "gtk" as USE flag to build.                      #'
	echo '######################################################################'
	echo
	depmod -a &>/dev/null || :
}

