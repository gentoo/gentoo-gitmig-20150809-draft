# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Authors Bruce Locke <blocke@shivan.org>, Martin Schlemmer <azarah@gentoo.org>,
#         Donny Davies <woodchip@gentoo.org>

MY_P="MPlayer-0.50pre"
PRE_VERSION="3"
S=${WORKDIR}/${MY_P}?

# Only install Skin if GUI should be build (gtk as USE flag)
if [ "`use gtk`" ] ; then
	A="${MY_P}${PRE_VERSION}.tar.bz2 default.tar.bz2 mp-arial-iso-8859-1.zip divx.dll"
	SRC_URI="ftp://mplayerhq.hu/MPlayer/releases/${A}
		 ftp://mplayerhq.hu/MPlayer/Skin/default.tar.bz2
		 ftp://mplayerhq.hu/MPlayer/releases/mp-arial-iso-8859-1.zip
		 http://mplayerhq.hu/MPlayer/releases/divx.dll"
else		  
        A="${MY_P}${PRE_VERSION}.tar.bz2 mp-arial-iso-8859-1.zip divx.dll"
        SRC_URI="ftp://mplayerhq.hu/MPlayer/releases/${A}
                 ftp://mplayerhq.hu/MPlayer/releases/mp-arial-iso-8859-1.zip
		 http://mplayerhq.hu/MPlayer/releases/divx.dll"
fi

DESCRIPTION="Media Player for Linux"
HOMEPAGE="http://www.mplayerhq.hu"

# Experimental USE flags dvd and decss
DEPEND="virtual/glibc
        dev-lang/nasm
        media-libs/win32codecs
	>=media-libs/divx4linux-20010824
        dvd? ( media-libs/libdvdread )
        decss? ( media-libs/libdvdcss )
	opengl? ( media-libs/mesa )
        sdl? ( media-libs/libsdl )
        ggi? ( media-libs/libggi )
        svga? ( media-libs/svgalib )
        X? ( virtual/x11 )
	gtk? ( >=x11-libs/gtk+-1.2.10-r4 )
        esd? ( media-sound/esound )
        alsa? ( media-libs/alsa-lib )
	ogg? ( media-libs/libogg )"

RDEPEND="virtual/glibc
        media-libs/win32codecs
        >=media-libs/divx4linux-20010824
        dvd? ( media-libs/libdvdread )
        decss? ( media-libs/libdvdcss )
	opengl? ( media-libs/mesa )
        sdl? ( media-libs/libsdl )
        ggi? ( media-libs/libggi )
        svga? ( media-libs/svgalib )
        X? ( virtual/x11 )
        gtk? ( >=x11-libs/gtk+-1.2.10-r4 )
	esd? ( media-sound/esound )
        alsa? ( media-libs/alsa-lib )
	ogg? ( media-libs/libogg )"


src_unpack() {

	if [ "`use gtk`" ] ; then
		unpack ${MY_P}${PRE_VERSION}.tar.bz2 default.tar.bz2 \
			mp-arial-iso-8859-1.zip
	else
		unpack ${MY_P}${PRE_VERSION}.tar.bz2 mp-arial-iso-8859-1.zip
	fi

	# Fix bug with the default Skin
	cd ${WORKDIR}/default
	patch <${FILESDIR}/default-skin.diff

}

src_compile() {

	local myconf
	use 3dnow  || myconf="${myconf} --disable-3dnow --disable-3dnowex"
	use mmx    || myconf="${myconf} --disable-mmx --disable-mmx2"
	use X      || myconf="${myconf} --disable-x11 --disable-xv"
	use gtk    && myconf="${myconf} --enable-gui"
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
	use decss  && myconf="${myconf} --enable-css"

	./configure --mandir=/usr/share/man --prefix=/usr --host=${CHOST} ${myconf} || die
	emake OPTFLAGS="${CFLAGS}" all || die
	
}

src_install() {

	make prefix=${D}/usr/share BINDIR=${D}/usr/bin install || die
	
	# MAN pages are already installed ...
	rm DOCS/*.1
	# Install the rest of the documentation
	dodir /usr/share/doc/${PF}
	cp -a DOCS/* ${D}/usr/share/doc/${PF}

	# Install the default Skin
	if [ "`use gtk`" ] ; then
		insinto /usr/share/mplayer/Skin/default
		doins ${WORKDIR}/default/*
		# Permissions is fried by default
		chmod a+rx ${D}/usr/share/mplayer/Skin/default/
		chmod a+r ${D}/usr/share/mplayer/Skin/default/*
	fi

	# Install the font used by OSD and the GUI
	dodir /usr/share/mplayer/fonts
	cp -a ${WORKDIR}/iso-8859-1/ ${D}/usr/share/mplayer/fonts
	dosym /usr/share/mplayer/fonts/iso-8859-1/arial-14/ /usr/share/mplayer/font

	# This tries setting up mplayer.conf automagically
	local video="sdl" audio="sdl"
	if [ "`use X`" ] ; then
		if [ "`use sdl`" ] ; then
			video="sdl"
		elif [ "`use ggi`" ] ; then
			video="ggi"
		elif [ "`use xv`" ] ; then
			video="xv"
                elif [ "`use dga`" ] ; then
                        video="dga"
		elif [ "`use opengl`" ] ; then
			video="gl"
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
	sed -e "s/vo=xv/vo=${video}/" -e "s/ao=oss/ao=${audio}/" -e 's/include =/#include =/' ${S}/etc/example.conf > ${T}/mplayer.conf

	insinto /etc
	doins ${T}/mplayer.conf 
	
	# Thanks goes to Mog for this one!
	insinto /usr/share/mplayer
	doins ${S}/etc/codecs.conf

	# Install the new divx.dll
	insinto /usr/lib/win32
	doins /usr/portage/distfiles/divx.dll
	
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
	echo '#   So, if you setup supports XVideo (xvinfo should give output),    #'
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

}

