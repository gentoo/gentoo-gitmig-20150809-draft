# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer/mplayer-1.0_pre5-r1.ebuild,v 1.6 2004/07/23 15:56:56 chriswhite Exp $

inherit eutils flag-o-matic kmod

IUSE="3dfx 3dnow aalib alsa altivec arts bidi debug divx4linux dvb cdparanoia directfb dvd edl encode esd fbdev gif ggi gtk ipv6 joystick jpeg libcaca lirc live lzo mad matroska matrox mpeg mmx mythtv nas network nls oggvorbis opengl oss rtc samba sdl sse svga tga theora truetype v4l v4l2 X xinerama xmms xvid"

BLUV=1.4
SVGV=1.9.17

# Handle PREversions as well
MY_PV="${PV/_/}"
S="${WORKDIR}/MPlayer-${MY_PV}"
SRC_URI="mirror://mplayer/MPlayer/releases/MPlayer-${MY_PV}.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-iso-8859-1.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-iso-8859-2.tar.bz2
	svga? ( http://mplayerhq.hu/~alex/svgalib_helper-${SVGV}-mplayer.tar.bz2 )
	gtk? ( mirror://mplayer/Skin/Blue-${BLUV}.tar.bz2 )"
# Only install Skin if GUI should be build (gtk as USE flag)
DESCRIPTION="Media Player for Linux"
HOMEPAGE="http://www.mplayerhq.hu/"

# 'encode' in USE for MEncoder.
RDEPEND="xvid? ( >=media-libs/xvid-0.9.0 )
	x86? ( divx4linux? (  >=media-libs/divx4linux-20030428 )
		 >=media-libs/win32codecs-0.60 )
	aalib? ( media-libs/aalib )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	bidi? ( dev-libs/fribidi )
	cdparanoia? ( media-sound/cdparanoia )
	directfb? ( dev-libs/DirectFB )
	dvd? ( dvdread? ( media-libs/libdvdread ) )
	encode? ( media-sound/lame
			>=media-libs/libdv-0.9.5 )
	esd? ( media-sound/esound )
	gif? ( media-libs/giflib
		media-libs/libungif )
	ggi? ( media-libs/libggi )
	gtk? ( media-libs/libpng
		virtual/x11
		=x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2* )
	jpeg? ( media-libs/jpeg )
	libcaca? ( media-libs/libcaca )
	lirc? ( app-misc/lirc )
	lzo? ( dev-libs/lzo )
	mad? ( media-libs/libmad )
	matroska? ( >=media-libs/libmatroska-0.6.0 )
	mpeg? ( media-libs/faad2 )
	nas? ( media-libs/nas )
	nls? ( sys-devel/gettext )
	oggvorbis? ( media-libs/libvorbis )
	opengl? ( virtual/opengl )
	png? ( media-libs/libpng )
	samba? ( >=net-fs/samba-2.2.8a )
	sdl? ( media-libs/libsdl )
	svga? ( media-libs/svgalib )
	!ia64? ( 
		theora? ( media-libs/libtheora )
		live? ( =media-plugins/live-2004.03.27 )
		)
	truetype? ( >=media-libs/freetype-2.1 )
	xinerama? ( virtual/x11 )
	xmms? ( media-sound/xmms )
	>=sys-apps/portage-2.0.36"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	app-arch/unzip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha ~amd64 ~ia64 ~hppa ~sparc"


pkg_setup() {
	echo
	einfo "Please note that we do not use C[XX]FLAGS from /etc/make.conf"
	einfo "or the environment, as the MPlayer guys then do not give support"
	einfo "in case of bug reports!."
	echo
	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	echo -ne "\a" ; sleep 1
	sleep 3
}

src_unpack() {

	unpack MPlayer-${MY_PV}.tar.bz2 \
		font-arial-iso-8859-1.tar.bz2 font-arial-iso-8859-2.tar.bz2

	use svga && unpack svgalib_helper-${SVGV}-mplayer.tar.bz2

	use gtk && unpack Blue-${BLUV}.tar.bz2

	cd ${S}

	# Fix head/tail call for new coreutils
	epatch ${FILESDIR}/${PN}-0.90-coreutils-fixup.patch

	#bug #49669, horrid syntax errors in help/help_mp-ro.h	
	epatch ${FILESDIR}/mplayer-1.0_pre4-help_mp-ro.h.patch

	#adds mythtv support to mplayer
	use mythtv && epatch ${FILESDIR}/mplayer-mythtv.patch

	# GCC 3.4 fixes
	epatch ${FILESDIR}/mplayer-1.0_pre4-alsa-gcc34.patch

	#Workaround for the altivec softscaler issues
	epatch ${FILESDIR}/mplayer-1.0_pre5-yuv2rbg_kludge.patch

	#bug #55936, eradicator's cachefill patch.
	epatch ${FILESDIR}/cachefill.patch

	#Setup the matrox makefile
	if use matrox; then
		get_kernel_info
		epatch ${FILESDIR}/mplayer-1.0_pre5-mga-kernel-2.6.patch
		sed -i -e \
		"s:^#KERNEL_OUTPUT_PATH=: \
		KERNEL_OUTPUT_PATH =${KV_OUTPUT}:" \
		${S}/Makefile
	fi # end of matrox related stuff

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
}

src_compile() {

	filter-flags -fPIE

	local myconf=
	################
	#Optional features#
	###############
	myconf="${myconf} $(use_enable bidi fribidi)"
	myconf="${myconf} $(use_enable cdparanoia)"
	myconf="${myconf} $(use_enable dvd mpdvdkit)"
	myconf="${myconf} $(use_enable edl)"
	myconf="${myconf} $(use_enable encode mencoder)"
	myconf="${myconf} $(use_enable gtk gui) $(use_enable gtk x11) $(use_enable gtk xv) $(use_enable gtk vm)"
	myconf="${myconf} $(use_enable ipv6 inet6)"
	myconf="${myconf} $(use_enable joystick)"
	myconf="${myconf} $(use_enable lirc)"
	if use ia64; then
		myconf="${myconf} --disable-live"
	else
		myconf="${myconf} $(use_enable live)"
	fi
	myconf="${myconf} $(use_enable network) $(use_enable network ftp)"
	myconf="${myconf} $(use_enable rtc)"
	myconf="${myconf} $(use_enable samba smb)"
	myconf="${myconf} $(use_enable truetype freetype)"
	myconf="${myconf} $(use_enable v4l tv-v4l)"
	myconf="${myconf} $(use_enable v4l tv-v4l2)"

	#########
	# Codecs #
	########
	myconf="${myconf} $(use_enable divx4linux)"
	myconf="${myconf} $(use_enable gif)"
	myconf="${myconf} $(use_enable jpeg)"
	myconf="${myconf} $(use_enable lzo liblzo)"
	myconf="${myconf} $(use_enable matroska external-matroska) $(use_enable !matroska internal-matroska)"
	myconf="${myconf} $(use_enable mpeg external-faad) $(use_enable !mpeg internal-faad)"
	myconf="${myconf} $(use_enable oggvorbis vorbis)"
	if use ia64;  then
		myconf="${myconf} --disable-theora"
	else
		myconf="${myconf} $(use_enable theora)"
	fi
	myconf="${myconf} $(use_enable xmms)"
	myconf="${myconf} $(use_enable xvid)"

	#############
	# Video Output #
	#############
	myconf="${myconf} $(use_enable 3dfx)"
	if use xvid && use 3dfx; then
		myconf="${myconf} --enable-tdfxvid"
	else
		myconf="${myconf} --disable-tdfxvid"
	fi
	myconf="${myconf} $(use_enable aalib aa)"
	myconf="${myconf} $(use_enable directfb)"
	myconf="${myconf} $(use_enable dvb)"
	myconf="${myconf} $(use_enable fbdev)"
	myconf="${myconf} $(use_enable ggi)"
	myconf="${myconf} $(use_enable libcaca caca)"
	if use matrox && use X; then
		myconf="${myconf} $(use_enable matrox xmga)"
	fi
	myconf="${myconf} $(use_enable opengl gl)"
	myconf="${myconf} $(use_enable sdl)"
	myconf="${myconf} $(use_enable svga)"
	myconf="${myconf} $(use_enable tga)"
	myconf="${myconf} $(use_enable xinerama)"

	#############
	# Audio Output #
	#############
	myconf="${myconf} $(use_enable alsa)"
	myconf="${myconf} $(use_enable arts)"
	myconf="${myconf} $(use_enable esd)"
	myconf="${myconf} $(use_enable mad)"
	myconf="${myconf} $(use_enable nas)"
	myconf="${myconf} $(use_enable oss ossaudio)"

	#################
	# Advanced Options #
	#################
	myconf="${myconf} $(use_enable 3dnow) $(use_enable 3dnow 3dnowex)"
	myconf="${myconf} $(use_enable altivec)"
	myconf="${myconf} $(use_enable debug)"
	myconf="${myconf} $(use_enable mmx) $(use_enable mmx mmx2)"
	myconf="${myconf} $(use_enable nls i18n)"
	myconf="${myconf} $(use_enable sse) $(use_enable sse sse2)"

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

	if [ -e /dev/.devfsd ]
	then
		myconf="${myconf} --enable-linux-devfs"
	fi

	# Build the matrox driver before mplayer configuration.
	# That way the configure script sees it and builds the support
	#build the matrox driver before the 
	if use matrox ; then
		if use x86 ; then
			check_KV
			cd ${S}/drivers
			# bad hack, will be fixed later
			addwrite /usr/src/linux/
			unset ARCH
			make all || die "Matrox build failed!  Your kernel may need to have `make mrproper` run on it before trying to use matrox support in this ebuild again."
			cd ${S}
		else
			einfo "Not building matrox driver.  It doesn't seem to like other archs.  Please let me know at chriswhite@gentoo.org if you find out otherwise."
		fi
	fi
	unset CFLAGS CXXFLAGS
	./configure --prefix=/usr \
		--confdir=/usr/share/mplayer \
		--datadir=/usr/share/mplayer \
		--disable-runtime-cpudetection \
		--enable-largefiles \
		--enable-menu \
		--enable-real \
		--with-reallibdir=${REALLIBDIR} \
		--with-x11incdir=/usr/X11R6/include \
		${myconf} || die

		# config.mak doesn't set GIF_LIB so gif related source files fail
		if use gif
		then
			sed -e "s:GIF_LIB =:GIF_LIB = -lgif:" -i config.mak
		else
			sed -e "s:GIF_LIB =:GIF_LIB = -lungif:" -i config.mak
		fi

	einfo "Make"
	make all || die "Failed to build MPlayer!"
	einfo "Make completed"

	# We build the shared libpostproc.so here so that our
	# mplayer binary is not linked to it, ensuring that we
	# do not run into issues ... (bug #14479)
	cd ${S}/libavcodec/libpostproc
	make SHARED_PP="yes" || die "Failed to build libpostproc.so!"
}

src_install() {

	einfo "Make install"
	make prefix=${D}/usr \
	     BINDIR=${D}/usr/bin \
		 LIBDIR=${D}/usr/lib \
	     CONFDIR=${D}/usr/share/mplayer \
	     DATADIR=${D}/usr/share/mplayer \
	     MANDIR=${D}/usr/share/man \
	     install || die "Failed to install MPlayer!"
	einfo "Make install completed"

	if use matrox; then
		cd ${S}/drivers
		insinto /lib/modules/${KV}/kernel/drivers/char
		doins mga_vid.${KV_OBJ}
	fi

	dodoc AUTHORS ChangeLog README
	# Install the documentation; DOCS is all mixed up not just html
	docinto /usr/share/doc/${PF} ; dodoc -r ${S}/DOCS

	# Copy misc tools to documentation path, as they're not installed
	# directly
	docinto /usr/share/doc/${PF} ; dodoc -r ${S}/TOOLS

	# Install the default Skin and Gnome menu entry
	if use gtk
	then
		dodir /usr/share/mplayer/Skin
		cp -r ${WORKDIR}/Blue ${D}/usr/share/mplayer/Skin/default || die

		# Fix the symlink
		rm -rf ${D}/usr/bin/gmplayer
		dosym mplayer /usr/bin/gmplayer
	fi

	if use gnome
	then
		insinto /usr/share/pixmaps
		newins ${S}/Gui/mplayer/pixmaps/logo.xpm mplayer.xpm
		insinto /usr/share/gnome/apps/Multimedia
		doins ${FILESDIR}/mplayer.desktop
	fi

	dodir /usr/share/mplayer/fonts
	local x=
	# Do this generic, as the mplayer people like to change the structure
	# of their zips ...
	for x in $(find ${WORKDIR}/ -type d -name 'font-arial-??-iso-*')
	do
		cp -Rd ${x} ${D}/usr/share/mplayer/fonts
	done
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
}

pkg_preinst() {

	if [ -d "${ROOT}/usr/share/mplayer/Skin/default" ]
	then
		rm -rf ${ROOT}/usr/share/mplayer/Skin/default
	fi
}

pkg_postinst() {

	if use ppc
	then
		echo
		einfo "When you see only GREEN salad on your G4 while playing"
		einfo "a DivX, you should recompile _without_ altivec enabled."
		einfo "Further information: http://bugs.gentoo.org/show_bug.cgi?id=18511"
		echo
		einfo "If everything functions fine with watching DivX and"
		einfo "altivec enabled, please drop a comment on the mentioned bug!"
		echo
		einfo "libpostproc is no longer installed by mplayer. If you have an"
		einfo "application that depends on it, install >=ffmpeg-0.4.8.20040222"
	fi

	if use matrox; then
		depmod -a &>/dev/null || :
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

