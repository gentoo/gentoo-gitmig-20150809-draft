# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer/mplayer-1.0_pre4-r5.ebuild,v 1.3 2004/07/19 04:24:07 chriswhite Exp $

inherit eutils flag-o-matic kmod

IUSE="3dfx 3dnow X aalib alsa arts bidi debug directfb divx4linux dvb dvd encode esd fbcon ggi gif gnome gtk ipv6 joystick jpeg libcaca lirc live mad matroska matrox mmx mpeg nas nls oggvorbis opengl oss png samba sdl sse svga theora truetype v4l v4l2 xinerama xmms xvid"

# NOTE to myself:  Test this thing with and without dvd/gtk+ support,
#                  as it seems the mplayer guys dont really care to
#                  make it work without dvd support.

BLUV=1.4
SVGV=1.9.17

# Handle PREversions as well
MY_PV="${PV/_/}"
S="${WORKDIR}/MPlayer-${MY_PV}"
SRC_URI="mirror://mplayer/releases/MPlayer-${MY_PV}.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-iso-8859-1.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-iso-8859-2.tar.bz2
	svga? ( http://mplayerhq.hu/~alex/svgalib_helper-${SVGV}-mplayer.tar.bz2 )
	gtk? ( mirror://mplayer/Skin/Blue-${BLUV}.tar.bz2 )"
# Only install Skin if GUI should be build (gtk as USE flag)
DESCRIPTION="Media Player for Linux"
HOMEPAGE="http://www.mplayerhq.hu/"

# 'encode' in USE for MEncoder.
RDEPEND="xvid? (
		ppc? ( >=media-libs/xvid-0.9.0 )
		amd64? ( >=media-libs/xvid-0.9.0 )
		x86? ( >=media-libs/xvid-0.9.0 )
		)
	x86? ( divx4linux? (  >=media-libs/divx4linux-20030428 )
		 >=media-libs/win32codecs-0.60 )
	png? ( media-libs/libpng )
	gtk? ( media-libs/libpng
	       virtual/x11
			=x11-libs/gtk+-1.2*
			=dev-libs/glib-1.2* )
	xinerama? ( virtual/x11 )
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
	lirc? ( app-misc/lirc )
	aalib? ( media-libs/aalib )
	svga? ( media-libs/svgalib )
	encode? ( media-sound/lame
	          >=media-libs/libdv-0.9.5 )
	xmms? ( media-sound/xmms )
	matroska? ( >=media-libs/libmatroska-0.6.0 )
	opengl? ( virtual/opengl )
	directfb? ( dev-libs/DirectFB )
	oggvorbis? ( media-libs/libvorbis )
	nls? ( sys-devel/gettext )
	media-sound/cdparanoia
	mpeg? ( media-libs/faad2 )
	samba? ( >=net-fs/samba-2.2.8a )
	theora? ( media-libs/libtheora )
	live? ( >=media-plugins/live-2004.01.05 )
	mad? ( media-libs/libmad )
	bidi? ( dev-libs/fribidi )
	libcaca? ( media-libs/libcaca )
	>=sys-apps/portage-2.0.36"
#	dvd? ( media-libs/libdvdnav )
# Hardcode paranoia support for now, as there is no
# related USE flag.

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	app-arch/unzip"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~alpha -amd64 -ia64 -hppa ~sparc"


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


	# fixes bug #55456 for amd64 and fullscreen Bug #43010
	epatch ${FILESDIR}/gui_vuln_code.patch

	# fixes missing str* linking bugs
	cp ${FILESDIR}/strl.c ${S}/osdep
	epatch ${FILESDIR}/str_undefined.patch

	# Fix head/tail call for new coreutils
	epatch ${FILESDIR}/${PN}-0.90-coreutils-fixup.patch

	#bug #49669, horrid syntax errors in help/help_mp-ro.h
	epatch ${FILESDIR}/${P}-help_mp-ro.h.patch

	#fixes bug #53634
	epatch ${FILESDIR}/real_demux.patch

	epatch ${FILESDIR}/${P}-alsa-gcc34.patch
	epatch ${FILESDIR}/${P}-altivec-gcc34.patch
	epatch ${FILESDIR}/${P}-gcc34-mtune.patch
	# fixes for mga driver with kernel 2.6
	if use matrox; then
		get_kernel_info

		epatch ${FILESDIR}/mga-kernel-2.6.patch
		sed -i -e "s/KERNEL_VERSION_HERE/${KV_VERSION_FULL}/" drivers/Makefile \
			|| die "sed failed on kernel version substitution"

		# preparing build for 2.6 mga kernel module
		cp ${KV_OUTPUT}/.config ${T}/
		ln -s /usr/src/linux/scripts ${T}/
		ln -s /usr/src/linux/include ${T}/
		sed -e "s:SUBDIRS:O=${T} SUBDIRS:" -i drivers/Makefile \
			|| die "sed failed setting O=${T}"
		sed -e "s:^MDIR = .*:MDIR = ${D}/lib/modules/${KV_VERSION_FULL}/kernel/drivers/char/:" -i drivers/Makefile \
			|| die "sed failed correcting module install path"
		sed -e "s:depmod -a::" -i drivers/Makefile \
			|| die "sed failed removing depmod"

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
		cd ${S}/libdha
		sed -i -e "s/^#CFLAGS/CFLAGS/" Makefile
	fi
}

src_compile() {

	filter-flags -fPIC

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
				--disable-xmga"

	use png || use gtk \
		|| myconf="${myconf} --disable-png"

	( use matrox && use X ) \
		&& myconf="${myconf} --enable-xmga" \
		|| myconf="${myconf} --disable-xmga"

	use gtk \
		&& myconf="${myconf} --enable-gui --enable-x11 \
		                     --enable-xv --enable-vm --enable-png"
	use png \
		&& myconf="${myconf} --enable-png"

	myconf="${myconf} `use_enable encode mencoder`"
	use encode && myconf="${myconf} --enable-tv"

	myconf="${myconf} `use_enable dvd mpdvdkit`"
	use dvd || myconf="${myconf} --disable-dvdread"

	# Disable dvdnav support as its not considered to be
	# functional anyhow, and will be removed.

	myconf="${myconf} `use_enable dvb`"
	use dvb || myconf="${myconf} --disable-dvbhead"

	#if the flag is enabled, use external rather then internal
	use matroska && myconf="${myconf} --disable-internal-matroska"
	use mpeg && myconf="${myconf} --disable-internal-faad"

	mconf="${myconf} `use_enable xvid`"
	( use xvid && use 3dfx ) \
		&& myconf="${myconf} --enable-tdfxvid" \
		||  myconf="${myconf} --disable-tdfxvid"

	use gif \
		|| myconf="${myconf} --disable-gif"

	use debug \
		&& myconf="${myconf} --enable-debug"

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

	has_pic && CC="${CC} `test_flag -fno-pic` `test_flag -nopie`"

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
		`use_enable xinerama` \
		`use_enable oggvorbis vorbis` \
		`use_enable esd` \
		`use_enable truetype freetype` \
		`use_enable opengl gl` \
		`use_enable libcaca caca` \
		`use_enable sdl` \
		`use_enable nls i18n` \
		`use_enable samba smb` \
		`use_enable aalib aa` \
		`use_enable oss ossaudio` \
		`use_enable ggi` \
		`use_enable svga` \
		`use_enable directfb` \
		`use_enable fbcon fbdev` \
		`use_enable alsa` \
		`use_enable arts` \
		`use_enable lirc` \
		`use_enable joystick` \
		`use_enable theora` \
		`use_enable bidi fribidi` \
		`use_enable nas` \
		`use_enable 3dfx tdfxfb` \
		`use_enable matrox mga` \
		`use_enable xmms` \
		`use_enable ipv6 inet6` \
		`use_enable live` \
		`use_enable v4l tv-v4l` \
		`use_enable v4l2 tv-v4l2` \
		`use_enable mpeg external-faad` \
		`use_enable matroska external-matroska` \
		`use_enable jpeg` \
		`use_enable mad` \
		`use_enable divx4linux` \
		${myconf} || die
	# Breaks with gcc-2.95.3, bug #14479:
	#  --enable-shared-pp \
	# Enable untested and currently unused code:
	#  --enable-dynamic-plugins \

	# emake borks on fast boxes - Azarah (07 Aug 2002)
	einfo "Make"
	make all || die "Failed to build MPlayer!"
	einfo "Make completed"

	# We build the shared libpostproc.so here so that our
	# mplayer binary is not linked to it, ensuring that we
	# do not run into issues ... (bug #14479)
	cd ${S}/libavcodec/libpostproc
	make SHARED_PP="yes" || die "Failed to build libpostproc.so!"

	if use matrox
	then
		unset ARCH
		local driverwasbuilt="ok"
		local dirtytrick="no"
		local oldwrite="${SANDBOX_WRITE}"
		cd ${S}/drivers
		if [ ${KV_MAJOR}.${KV_MINOR} = "2.6" -a ${KV_PATCH} -le 5 ]; then
			einfo "Kernel < 2.6.6, have to remove your include/asm and .config"
			einfo "temporarily. Putting them into ${T}, will try to restore them later."
			dirtytrick="yes"
			addwrite /usr/src/linux/
			mv /usr/src/linux/.config ${T}/savedconfig
			mv /usr/src/linux/include/asm ${T}/savedasm
			SANDBOX_WRITE="${oldwrite}"
		fi
		make all || driverwasbuilt="no"
		if [ ${dirtytrick} = "yes" ]; then
			addwrite /usr/src/linux
			mv ${T}/savedconfig /usr/src/linux/.config
			mv ${T}/savedasm /usr/src/linux/include/asm
			SANDBOX_WRITE="${oldwrite}"
		fi
		if [ ${driverwasbuilt} = "no" ]; then
			die "Failed to build matrox driver!"
		fi
	fi
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

	# libpostproc is now installed by >=ffmpeg-0.4.8.20040222
#	cd ${S}/libavcodec/libpostproc
#	make prefix=${D}/usr \
#	     SHARED_PP="yes" \
#	     install || die "Failed to install libpostproc.so!"
#	cd ${S}

	dodoc AUTHORS ChangeLog README
	# Install the documentation; DOCS is all mixed up not just html
	find ${S}/DOCS -type d | xargs -- chmod 0755
	cp -r ${S}/DOCS ${D}/usr/share/doc/${PF}/ || die

	# Copy misc tools to documentation path, as they're not installed
	# directly
	find ${S}/TOOLS -type d | xargs -- chmod 0755
	cp -r ${S}/TOOLS ${D}/usr/share/doc/${PF} || die

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
