# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer/mplayer-0.91.ebuild,v 1.4 2003/09/05 14:25:22 lanius Exp $

IUSE="dga oss xmms jpeg 3dfx sse matrox sdl X svga ggi oggvorbis 3dnow aalib gnome xv opengl truetype dvd gtk gif esd fbcon encode alsa directfb arts dvb gtk2 samba"

inherit eutils

# NOTE to myself:  Test this thing with and without dvd/gtk+ support,
#                  as it seems the mplayer guys dont really care to
#                  make it work without dvd support.

# Handle PREversions as well
MY_PV="${PV/_/}"
S="${WORKDIR}/MPlayer-${MY_PV}"
SRC_URI="http://mplayerhq.hu/MPlayer/releases/MPlayer-${MY_PV}.tar.bz2
	http://mplayerhq.hu/MPlayer/releases/fonts/font-arial-iso-8859-1.tar.bz2
	http://mplayerhq.hu/MPlayer/releases/fonts/font-arial-iso-8859-2.tar.bz2
	svga? ( http://mplayerhq.hu/~alex/svgalib_helper-1.9.17-mplayer.tar.bz2 )
	gtk? ( http://mplayerhq.hu/MPlayer/Skin/Blue-1.0.tar.bz2 )"
# Only install Skin if GUI should be build (gtk as USE flag)
DESCRIPTION="Media Player for Linux"
HOMEPAGE="http://www.mplayerhq.hu/"

# 'encode' in USE for MEncoder.
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
	mpeg? ( media-libs/faad2 )
	samba? ( net-fs/samba )
	>=sys-apps/portage-2.0.36"
#	dvd? ( media-libs/libdvdnav )
# Hardcode paranoia support for now, as there is no
# related USE flag.

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	app-arch/unzip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc"


src_unpack() {

	unpack MPlayer-${MY_PV}.tar.bz2 \
		font-arial-iso-8859-1.tar.bz2 font-arial-iso-8859-2.tar.bz2

	use svga && unpack svgalib_helper-1.9.17-mplayer.tar.bz2

	use gtk && unpack Blue-1.0.tar.bz2

	# Use gtk-2.x
	cd ${S}; epatch ${FILESDIR}/${PN}-0.90_rc4-gtk2.patch

	# Fix head/tail call for new coreutils
	cd ${S}; epatch ${FILESDIR}/${PN}-0.90-coreutils-fixup.patch

	# Fix mencoder segfaulting with bad arguments
	cd ${S}; epatch ${FILESDIR}/mencoder-segfault.patch

	# Fix mplayer to detect detect/use altivec on benh kernels,
	# bug #18511.
	use ppc && \
		(cd ${S}; epatch ${FILESDIR}/${PN}-0.90-ppc-benh-2.patch)

	#Fixing divx 2003 API
	if has_version '>=media-libs/divx4linux-20030428'
	then
		einfo "DivX 20030428 found"
		cd ${S}; epatch ${FILESDIR}/${PN}-0.90-divx.patch
	else
		einfo "Old DivX Api found"
	fi

	if [ "`use svga`" ]
	then
		echo
		einfo "Enabling vidix non-root mode."
		einfo "(You need a proper svgalib_helper.o module for your kernel"
		einfo " to actually use this)"
		echo

		mv ${WORKDIR}/svgalib_helper ${S}/libdha
		cd ${S}/libdha
		sed -i -e "s/^#CFLAGS/CFLAGS/" Makefile
	fi

	cp -r ${S}/postproc ${S}/postproc.so
}

src_compile() {

	use matrox && check_KV

	local myconf=

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
	# Disable dvdnav support as its not considered to be
	# functional anyhow, and will be removed.

	use xmms \
		&& myconf="${myconf} --enable-xmms"

	use mpeg \
		&& myconf="${myconf} --enable-faad" \
		|| myconf="${myconf} --disable-faad"

	use matrox \
		&& myconf="${myconf} --enable-mga" \
		|| myconf="${myconf} --disable-mga"

	use 3dfx \
		&& myconf="${myconf} --enable-tdfxfb"
	# --enable-3dfx is broken according to the MPlayer guys.

	use dvb \
		&& myconf="${myconf} --enable-dvb" \
		|| myconf="${myconf} --disable-dvb"

	use nls \
		&& myconf="${myconf} --enable-i18n" \
		|| myconf="${myconf} --disable-i18n"

	use samba \
		&& myconf="${myconf} --enable-smb" \
		|| myconf="${myconf} --disable-smb"

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
		--enable-real \
		--with-reallibdir=${REALLIBDIR} \
		--with-x11incdir=/usr/X11R6/include \
		${myconf} || die
	# Breaks with gcc-2.95.3, bug #14479:
	#  --enable-shared-pp \
	# Enable untested and currently unused code:
	#  --enable-dynamic-plugins \

	# emake borks on fast boxes - Azarah (07 Aug 2002)
	make all || die "Failed to build MPlayer!"

	# We build the shared libpostproc.so here so that our
	# mplayer binary is not linked to it, ensuring that we
	# do not run into issues ... (bug #14479)
	cd ${S}/postproc.so
	make SHARED_PP="yes" || die "Failed to build libpostproc.so!"

	if [ -n "`use matrox`" ]
	then
		cd ${S}/drivers
		make all || die "Failed to build matrox driver!"
	fi
}

src_install() {

	make prefix=${D}/usr \
	     BINDIR=${D}/usr/bin \
		 LIBDIR=${D}/usr/lib \
	     CONFDIR=${D}/usr/share/mplayer \
	     DATADIR=${D}/usr/share/mplayer \
	     MANDIR=${D}/usr/share/man \
	     install || die "Failed to install MPlayer!"

	# Install our libpostproc.so ...
	cd ${S}/postproc.so
	make prefix=${D}/usr \
	     SHARED_PP="yes" \
	     install || die "Failed to install libpostproc.so!"
	cd ${S}

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

	dodoc AUTHORS ChangeLog README
	# Install the documentation; DOCS is all mixed up not just html
	cp -r ${S}/DOCS ${D}/usr/share/doc/${PF}/ || die

	# Copy misc tools to documentation path, as they're not installed
	# directly
	cp -r ${S}/TOOLS ${D}/usr/share/doc/${PF} || die

	# Install the default Skin and Gnome menu entry
	if [ -n "`use gtk`" ]
	then
		dodir /usr/share/mplayer/Skin
		cp -r ${WORKDIR}/Blue ${D}/usr/share/mplayer/Skin/default || die

		# Fix the symlink
		rm -rf ${D}/usr/bin/gmplayer
		dosym mplayer /usr/bin/gmplayer
	fi

	if [ -n "`use gnome`" ]
	then
		insinto /usr/share/pixmaps
		newins ${S}/Gui/mplayer/pixmaps/logo.xpm mplayer.xpm
		insinto /usr/share/gnome/apps/Multimedia
		doins ${FILESDIR}/mplayer.desktop
	fi

	dodir /usr/share/mplayer/fonts
	cp -a ${WORKDIR}/font-arial* ${D}/usr/share/mplayer/fonts
	# Fix the font symlink ...
	rm -rf ${D}/usr/share/mplayer/font
	dosym fonts/font-arial-14-iso-8859-1 /usr/share/mplayer/font

	insinto /etc
	newins ${S}/etc/example.conf mplayer.conf
	dosed -e 's/include =/#include =/' /etc/mplayer.conf
	dosed -e 's/fs=yes/fs=no/' /etc/mplayer.conf
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

pkg_preinst() {

	if [ -d "${ROOT}/usr/share/mplayer/Skin/default" ]
	then
		rm -rf ${ROOT}/usr/share/mplayer/Skin/default
	fi
}

pkg_postinst() {

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
