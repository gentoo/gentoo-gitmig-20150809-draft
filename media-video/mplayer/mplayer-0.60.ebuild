# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer/mplayer-0.60.ebuild,v 1.1 2002/01/04 18:33:08 azarah Exp $

# Handle PREversions as well
MY_PV=${PV/_/}
S="${WORKDIR}/MPlayer-${MY_PV}"
# Only install Skin if GUI should be build (gtk as USE flag)
SRC_URI="ftp://mplayerhq.hu/MPlayer/releases/MPlayer-${MY_PV}.tar.bz2
	 ftp://mplayerhq.hu/MPlayer/releases/mp-arial-iso-8859-1.zip
	 gtk? ( ftp://mplayerhq.hu/MPlayer/Skin/default.tar.bz2 )"
DESCRIPTION="Media Player for Linux"
HOMEPAGE="http://www.mplayerhq.hu/"

# 'encode' in USE for MEncoder
# Experimental USE flags dvd and decss
RDEPEND="virtual/glibc
        >=media-libs/win32codecs-${PV}
	>=media-libs/divx4linux-20011025
        dvd? ( media-libs/libdvdread )
        decss? ( media-libs/libdvdcss )
	opengl? ( virtual/opengl )
        sdl? ( media-libs/libsdl )
        ggi? ( media-libs/libggi )
        svga? ( media-libs/svgalib )
        X? ( virtual/x11 )
	gtk? ( >=x11-libs/gtk+-1.2.10-r4 )
        esd? ( media-sound/esound )
        alsa? ( media-libs/alsa-lib )
	ogg? ( media-libs/libogg )
	encode? ( media-sound/lame )"

DEPEND="${RDEPEND}
	dev-lang/nasm
	app-arch/unzip"


src_unpack() {

	unpack ${A}

	# Fix bug with the default Skin
	if [ "`use gtk`" ] ; then
		cd ${WORKDIR}/default
		patch < ${FILESDIR}/default-skin.diff || die "skin patch failed"
	fi

	if [ "`use mga`" ] ; then
		cd ${S}/drivers;
		patch < ${FILESDIR}/mga_vid_devfs.patch || die "mga patch failed"
	fi
}

src_compile() {

	local myconf
	use 3dnow  || myconf="${myconf} --disable-3dnow --disable-3dnowex"
	use mmx    || myconf="${myconf} --disable-mmx --disable-mmx2"
	use X      || myconf="${myconf} --disable-x11 --disable-xv --disable-xmga"
	# Try to fix bug where build will fail with gtk in USE, but not X
	# NB: hope opengl, sdl, ggi build fine ... i will test later.
	use gtk    && myconf="${myconf} --enable-gui --enable-x11 --enable-xv"
	use oss    || myconf="${myconf} --disable-ossaudio"
	use nls    || myconf="${myconf} --disable-nls"
	use opengl || myconf="${myconf} --disable-gl"
	use sdl    || myconf="${myconf} --disable-sdl"
	use ggi    || myconf="${myconf} --disable-ggi"
	use sse    || myconf="${myconf} --disable-sse"
	use svga   || myconf="${myconf} --disable-svga"
	use alsa   || myconf="${myconf} --disable-alsa"
	use esd    || myconf="${myconf} --disable-esd"
	use ogg    || myconf="${myconf} --disable-oggvorbis"
	use encode && myconf="${myconf} --enable-mencoder --enable-tv"
	use encode || myconf="${myconf} --disable-mencoder"
	use dvd    && myconf="${myconf} --enable-dvdread"
	use decss  && myconf="${myconf} --enable-dvdread --enable-css"
	use mga    && myconf="${myconf} --enable-mga"
	use mga    && \
	use X      && myconf="${myconf} --enable-xmga"

	# Crashes on start when compiled with most optimizations.
	# The code have CPU detection code now, with CPU specific
	# optimizations, so extra should not be needed and is not
	# recommended by the authors
	CFLAGS="-O2 -pipe"
	CXXFLAGS="-O2 -pipe"
	
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    ${myconf} || die
		    
	emake OPTFLAGS="${CFLAGS}" all || die
	
	if [ "`use mga`" ] ; then
		cd drivers
		emake all
	fi
}

src_install() {

	make prefix=${D}/usr/share					\
	     BINDIR=${D}/usr/bin					\
	     CONFDIR=${D}/usr/share/mplayer				\
	     mandir=${D}/usr/share/man					\
	     install || die
	
	# MAN pages are already installed ...
	rm DOCS/*.1
	# Install the rest of the documentation
	dodir /usr/share/doc/${PF}
	cp -a DOCS/* ${D}/usr/share/doc/${PF}
	doalldocs

	# Install the default Skin and Gnome menu entry
	if [ "`use gtk`" ] ; then
	
		insinto /usr/share/mplayer/Skin/default
		doins ${WORKDIR}/default/*
		# Permissions is fried by default
		chmod a+rx ${D}/usr/share/mplayer/Skin/default/
		chmod a+r ${D}/usr/share/mplayer/Skin/default/*

		insinto /usr/share/pixmaps
		newins ${S}/Gui/mplayer/pixmaps/icon.xpm mplayer.xpm
		insinto /usr/share/gnome/apps/Multimedia
		doins ${FILESDIR}/mplayer.desktop
	fi

	# Install the font used by OSD and the GUI
	dodir /usr/share/mplayer/fonts
	cp -a ${WORKDIR}/iso-8859-1/ ${D}/usr/share/mplayer/fonts
	dosym /usr/share/mplayer/fonts/iso-8859-1/arial-14/ /usr/share/mplayer/font

	# This tries setting up mplayer.conf automagically
	local video="sdl" audio="sdl"
	if [ "`use X`" ] ; then
		if [ "`use gtk`" ] ; then
			video="xv"
		elif [ "`use sdl`" ] ; then
			video="sdl"
		elif [ "`use xv`" ] ; then
			video="xv"
		elif [ "`use opengl`" ] ; then
			video="gl"
		elif [ "`use ggi`" ] ; then
			video="ggi"
                elif [ "`use dga`" ] ; then
                        video="dga"
		else
			video="x11"
		fi
	else
		if [ "`use fbcon`" ] ; then
			video="fbdev"
                elif [ "`use svga`" ] ; then
                        video="svga"
		elif [ "`use aalib`" ] ; then
			video="aa"
		fi
	fi
	if [ "`use sdl`" ] ; then
		audio="sdl"
	elif [ "`use alsa`" ] ; then
		audio="alsa"
	elif [ "`use oss`" ] ; then
		audio="oss"
	fi
	
	# Note to myself:  do not change " into '
	sed -e "s/vo=xv/vo=${video}/"					\
	    -e "s/ao=oss/ao=${audio}/"					\
	    -e 's/include =/#include =/'				\
	    ${S}/etc/example.conf > ${T}/mplayer.conf

	insinto /etc
	doins ${T}/mplayer.conf 
	
	insinto /usr/share/mplayer
	doins ${S}/etc/codecs.conf

	if [ "`use mga`" ] ; then
		dodir /lib/modules/${KVERS}/kernel/drivers/char
		cp ${S}/drivers/mga_vid.o ${D}/lib/modules/${KVERS}/kernel/drivers/char
	fi
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
	echo '# NB: the GUI needs "gtk" as USE flag to build.                      #'
	echo '######################################################################'
	echo
	depmod -a
}

