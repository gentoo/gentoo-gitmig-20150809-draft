# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer/mplayer-1.0_pre4-r7.ebuild,v 1.20 2004/10/24 13:56:09 chriswhite Exp $

inherit eutils flag-o-matic kmod

IUSE="3dfx 3dnow 3dnowex aalib alsa altivec arts bidi debug divx4linux dvb cdparanoia directfb dvd dvdread edl encode esd fbcon gif ggi gtk ipv6 joystick jpeg libcaca lirc live lzo mad  matroska matrox mmx mmx2 mpeg mythtv nas network nls oggvorbis opengl oss png real rtc samba sdl sse svga tga theora truetype v4l v4l2 xinerama X xmms xv xvid gnome"

BLUV=1.4
SVGV=1.9.17

# Handle PREversions as well
MY_PV="${PV/_/}"
S="${WORKDIR}/MPlayer-${MY_PV}"
SRC_URI="mirror://mplayer/MPlayer/releases/MPlayer-${MY_PV}.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-iso-8859-1.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-iso-8859-2.tar.bz2
	mirror://gentoo/${P}-mga-kernel2.6.patch.tar.bz2
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
	dvdread? ( media-libs/libdvdread )
	encode? ( media-sound/lame
			>=media-libs/libdv-0.9.5 )
	esd? ( media-sound/esound )
	gif? ( media-libs/giflib
		media-libs/libungif )
	ggi? ( media-libs/libggi )
	gtk? (
		media-libs/libpng
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
		live? (
			x86? ( >=media-plugins/live-2004.07.20 )
			amd64? ( >=media-plugins/live-2004.03.27 )
			alpha? ( >=media-plugins/live-2004.07.20 )
		)
	)
	truetype? ( >=media-libs/freetype-2.1 )
	xinerama? ( virtual/x11 )
	xmms? ( media-sound/xmms )
	>=sys-apps/portage-2.0.36
	sys-libs/ncurses"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	app-arch/unzip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha amd64 ~ia64 ~hppa ~sparc"

src_unpack() {

	unpack MPlayer-${MY_PV}.tar.bz2 \
		font-arial-iso-8859-1.tar.bz2 font-arial-iso-8859-2.tar.bz2

	use svga && unpack svgalib_helper-${SVGV}-mplayer.tar.bz2

	use gtk && unpack Blue-${BLUV}.tar.bz2

	cd ${S}

	# fixes bug reported by email from Selwyn Tang
	epatch ${FILESDIR}/${P}-mpst.patch

	# fixes bug #55456 for amd64 and fullscreen Bug #43010
	epatch ${FILESDIR}/gui_vuln_code.patch

	# fixes missing str* linking bugs
	cp ${FILESDIR}/strl.c ${S}/osdep
	epatch ${FILESDIR}/str_undefined.patch

	# Fix head/tail call for new coreutils
	epatch ${FILESDIR}/${PN}-0.90-coreutils-fixup.patch

	#bug #49669, horrid syntax errors in help/help_mp-ro.h	
	epatch ${FILESDIR}/mplayer-1.0_pre4-help_mp-ro.h.patch

	#fixes bug #53634
	epatch ${FILESDIR}/real_demux.patch

	#Fixes an upstream bug with odml code
	epatch ${FILESDIR}/mplayer-odml.patch

	#adds mythtv support to mplayer
	use mythtv && epatch ${FILESDIR}/mplayer-mythtv.patch

	#fixes a live api bug
	if use live && ( use x86 || use alpha )
	then
		epatch ${FILESDIR}/mplayer-1.0_pre5-live.patch
	fi

	# GCC 3.4 fixes
	epatch ${FILESDIR}/mplayer-1.0_pre4-alsa-gcc34.patch

	# bug #55936, patch from eradicator- fix caching problems.
	epatch ${FILESDIR}/cachefill.patch

	#bug #58082.  Fixes LANGUAGE variable issues
	epatch ${FILESDIR}/mplayer-1.0_pre5-r1-conf_locale.patch

	#Setup the matrox makefile
	if use matrox; then
		get_kernel_info
		epatch ${DISTDIR}/${P}-mga-kernel2.6.patch.tar.bz2
		sed -i -e \
		"s:^#KERNEL_OUTPUT_PATH=: \
		KERNEL_OUTPUT_PATH =${KV_OUTPUT}:" \
		${S}/Makefile || die "failed to sed ${S}/Makefile"
	fi # end of matrox related stuff

	# Fix hppa compilation
	if use hppa; then
		sed -i -e "s/-O4/-O1/" "${S}/configure" || die "failed to sed configure"
	fi

	if use svga; then
		echo
		einfo "Enabling vidix non-root mode."
		einfo "(You need a proper svgalib_helper.o module for your kernel"
		einfo " to actually use this)"
		echo

		mv "${WORKDIR}/svgalib_helper" "${S}/libdha"
	fi
	#Remove kernel-2.6 workaround as the problem it works around is
	#fixed, and the workaround breaks sparc
	if use sparc; then
		sed -i -e 's:#define __KERNEL__::' osdep/kerneltwosix.h || die "failed to apply kernel-2.6 workarround"
	fi
}

src_compile() {

	filter-flags -fPIE -fPIC -fstack-protector -fforce-addr -momit-leaf-frame-pointer -msse2
	local myconf=

	if use dvd; then
		myconf="${myconf} $(use_enable dvdread) $(use_enable !dvdread mpdvdkit)"
	else
		myconf="${myconf} --disable-dvdread --disable-mpdvdkit"
	fi

	if use !gtk && use !X && use !xv && use !xinerama; then
		myconf="${myconf} --disable-gui --disable-x11 --disable-xv --disable-xmga --disable-xinerama --disable-vm --disable-xvmc"
	else
		#note we ain't touching --enable-vm.  That should be locked down in the future.
		myconf="${myconf} --enable-x11 $(use_enable xinerama) $(use_enable xv) $(use_enable gtk gui)"
	fi

	#disable png *only* if the flag is off, and gtk gui isn't on.
	if use png ||  use gtk; then
		myconf="${myconf} --enable-png"
	else
		myconf="${myconf} --disable-png"
	fi

	if use ia64 || use !network; then
		myconf="${myconf} --disable-live"
	else
		myconf="${myconf} $(use_enable live)"
	fi

	if use ia64; then
		myconf="${myconf} --disable-theora"
	else
		myconf="${myconf} $(use_enable theora)"
	fi

	if use xvid && use 3dfx; then
		myconf="${myconf} --enable-tdfxvid"
	else
		myconf="${myconf} --disable-tdfxvid"
	fi
	if use matrox && use X; then
		myconf="${myconf} $(use_enable matrox xmga)"
	fi

	if use svga
	then
		myconf="${myconf} --enable-svga"
	else
		myconf="${myconf} --disable-svga --disable-vidix"
	fi

	myconf="${myconf} $(use_enable 3dnow)"
	myconf="${myconf} $(use_enable 3dnowex)"
	myconf="${myconf} $(use_enable sse)"
	myconf="${myconf} $(use_enable mmx)"
	myconf="${myconf} $(use_enable mmx2)"

	if use real
	then
		if [ -d /usr/lib/win32 ]
		then
			REALLIBDIR="/usr/lib/win32"
		else
			eerror "Real libs not found!  Install a stable version of win32codecs"
			die "Real libs not found"
		fi
	fi

	if [ -e /dev/.devfsd ]; then
		myconf="${myconf} --enable-linux-devfs"
	fi

	# Build the matrox driver before mplayer configuration.
	# That way the configure script sees it and builds the support
	#build the matrox driver before the 
	if use matrox && use x86; then
		check_KV
		cd ${S}/drivers
		# bad hack, will be fixed later
		addwrite ${ROOT}/usr/src/linux/
		unset ARCH
		make all || die "Matrox build failed!  Your kernel may need to have `make mrproper` run on it before trying to use matrox support in this ebuild again."
		cd ${S}
	fi

	./configure --prefix=/usr 		\
		--confdir=/usr/share/mplayer	\
		--datadir=/usr/share/mplayer	\
		--disable-runtime-cpudetection	\
		--enable-largefiles		\
		--enable-menu			\
		--enable-real			\
		--with-reallibdir=${REALLIBDIR} 	\
		--with-x11incdir=/usr/X11R6/include	\
		${myconf} 			\
		$(use_enable bidi fribidi)	\
		$(use_enable cdparanoia)	\
		$(use_enable edl)		\
		$(use_enable encode mencoder)	\
		$(use_enable ipv6 inet6)	\
		$(use_enable joystick)		\
		$(use_enable lirc)		\
		$(use_enable network) 		\
		$(use_enable network ftp)	\
		$(use_enable rtc)		\
		$(use_enable samba smb)		\
		$(use_enable truetype freetype)	\
		$(use_enable v4l tv-v4l)	\
		$(use_enable v4l2 tv-v4l2)	\
		$(use_enable divx4linux)	\
		$(use_enable gif)		\
		$(use_enable jpeg)		\
		$(use_enable lzo liblzo)	\
		$(use_enable matroska external-matroska) $(use_enable !matroska internal-matroska)	\
		$(use_enable mpeg external-faad)         $(use_enable !mpeg internal-faad)		\
		$(use_enable oggvorbis vorbis)	\
		$(use_enable xmms)		\
		$(use_enable xvid)		\
		$(use_enable 3dfx)		\
		$(use_enable aalib aa)		\
		$(use_enable directfb)		\
		$(use_enable dvb)		\
		$(use_enable fbcon fbdev)		\
		$(use_enable ggi)		\
		$(use_enable libcaca caca) 	\
		$(use_enable opengl gl) 	\
		$(use_enable sdl) 		\
		$(use_enable tga) 		\
		$(use_enable alsa) 		\
		$(use_enable arts) 		\
		$(use_enable esd) 		\
		$(use_enable mad) 		\
		$(use_enable nas) 		\
		$(use_enable oss ossaudio) 	\
		$(use_enable altivec) 		\
		$(use_enable debug) 		\
		$(use_enable nls i18n) 		\
		|| die

		# when gif is autodetected, GIF_LIB is set correctly.  We're explicitly controlling it, and it doesn't behave correctly.
		# so... we have to help it along.
		if use gif; then
			sed -e "s:GIF_LIB =:GIF_LIB = -lungif:" -i config.mak || die "failed to apply GIF_LIB fix"
		fi

	make all || die "Failed to build MPlayer!"

	# We build the shared libpostproc.so here so that our
	# mplayer binary is not linked to it, ensuring that we
	# do not run into issues ... (bug #14479)
	cd "${S}/libavcodec/libpostproc"
	make SHARED_PP="yes" || die "Failed to build libpostproc.so!"
}

src_install() {
	make prefix=${D}/usr \
	     BINDIR=${D}/usr/bin \
		 LIBDIR=${D}/usr/lib \
	     CONFDIR=${D}/usr/share/mplayer \
	     DATADIR=${D}/usr/share/mplayer \
	     MANDIR=${D}/usr/share/man \
	     install || die "Failed to install MPlayer!"

	if use matrox; then
		cd ${S}/drivers
		insinto "/lib/modules/${KV}/kernel/drivers/char"
		doins "mga_vid.${KV_OBJ}"
	fi

	dodoc AUTHORS ChangeLog README

	# Install the documentation; DOCS is all mixed up not just html
	cp -r "${S}/DOCS" "${D}/usr/share/doc/${PF}/" || die
	cp -r "${S}/TOOLS" "${D}/usr/share/doc/${PF}/" || die

	find "${D}/usr/share/doc/${PF}" -type d | xargs -- chmod 0755
	# and yes, we are nuking the +x bit.
	find "${D}/usr/share/doc/${PF}" -type f | xargs -- chmod 0644


	# Install the default Skin and Gnome menu entry
	if use gtk; then
		dodir /usr/share/mplayer/Skin
		cp -r ${WORKDIR}/Blue ${D}/usr/share/mplayer/Skin/default || die

		# Fix the symlink
		rm -rf ${D}/usr/bin/gmplayer
		dosym mplayer /usr/bin/gmplayer
	fi

	if use gnome; then
		insinto /usr/share/pixmaps
		newins ${S}/Gui/mplayer/pixmaps/logo.xpm mplayer.xpm
		insinto /usr/share/gnome/apps/Multimedia
		doins ${FILESDIR}/mplayer.desktop
	fi

	dodir /usr/share/mplayer/fonts
	local x=
	# Do this generic, as the mplayer people like to change the structure
	# of their zips ...
	#this is ugly, fix it at some point.
	for x in $(find ${WORKDIR}/ -type d -name 'font-arial-??-iso-*')
	do
		cp -Rd "${x}" "${D}/usr/share/mplayer/fonts"
	done
	# Fix the font symlink ...
	rm -rf ${D}/usr/share/mplayer/font
	dosym fonts/font-arial-14-iso-8859-1 /usr/share/mplayer/font

	insinto /etc
	newins ${S}/etc/example.conf mplayer.conf
	dosed   's/include =/#include =/' /etc/mplayer.conf || die "failed to dosed mplayer.conf"
	dosed 	's/fs=yes/fs=no/' /etc/mplayer.conf || die "failed to fix the default mplayer.conf"

	dosym ../../../etc/mplayer.conf /usr/share/mplayer/mplayer.conf

	insinto /usr/share/mplayer
	doins "${S}/etc/codecs.conf" "${S}/etc/input.conf" "${S}/etc/menu.conf"
}

pkg_preinst() {
	if [ -d "${ROOT}/usr/share/mplayer/Skin/default" ]; then
		rm -rf ${ROOT}/usr/share/mplayer/Skin/default
	fi
}

pkg_postinst() {
	if use ppc; then
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
		depmod -a &>/dev/null || true
	fi
}

pkg_postrm() {

	# Cleanup stale symlinks
	if [ -L ${ROOT}/usr/share/mplayer/font -a ! -e ${ROOT}/usr/share/mplayer/font ]; then
		rm -f ${ROOT}/usr/share/mplayer/font
	fi

	if [ -L ${ROOT}/usr/share/mplayer/subfont.ttf -a ! -e ${ROOT}/usr/share/mplayer/subfont.ttf ]; then
		rm -f ${ROOT}/usr/share/mplayer/subfont.ttf
	fi
}

