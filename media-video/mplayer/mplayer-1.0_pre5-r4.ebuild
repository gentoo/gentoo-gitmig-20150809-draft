# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer/mplayer-1.0_pre5-r4.ebuild,v 1.24 2004/11/14 09:51:36 corsair Exp $

inherit eutils flag-o-matic kernel-mod

IUSE="3dfx 3dnow 3dnowex aalib alsa altivec arts bidi debug divx4linux doc dvb cdparanoia directfb dvd dvdread edl encode esd fbcon gif ggi gtk i8x0 ipv6 jack joystick jpeg libcaca lirc live lzo mad matroska matrox mpeg mmx mmx2 mythtv nas network nls nvidia oggvorbis opengl oss png real rtc samba sdl sse svga tga theora truetype v4l v4l2 X xanim xinerama xmms xv xvid xvmc"

BLUV=1.4
SVGV=1.9.17

# Handle PREversions as well
MY_PV="${PV/_/}"
S="${WORKDIR}/MPlayer-${MY_PV}"
SRC_URI="mirror://mplayer/MPlayer/releases/MPlayer-${MY_PV}.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-iso-8859-1.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-iso-8859-2.tar.bz2
	mirror://mplayer/releases/fonts/font-arial-cp1250.tar.bz2
	mirror://gentoo/${P}-alsa-gui.patch.tar.bz2
	svga? ( http://mplayerhq.hu/~alex/svgalib_helper-${SVGV}-mplayer.tar.bz2 )
	gtk? ( mirror://mplayer/Skin/Blue-${BLUV}.tar.bz2 )"

# Only install Skin if GUI should be build (gtk as USE flag)
DESCRIPTION="Media Player for Linux"
HOMEPAGE="http://www.mplayerhq.hu/"

# 'encode' in USE for MEncoder.
RDEPEND="xvid? ( >=media-libs/xvid-0.9.0 )
	x86? (
		divx4linux? (  >=media-libs/divx4linux-20030428 )
		>=media-libs/win32codecs-20040916
		)
	aalib? ( media-libs/aalib )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	bidi? ( dev-libs/fribidi )
	cdparanoia? ( media-sound/cdparanoia )
	directfb? ( dev-libs/DirectFB )
	dvd? ( dvdread? ( media-libs/libdvdread ) )
	encode? (
		media-sound/lame
		>=media-libs/libdv-0.9.5
		)
	esd? ( media-sound/esound )
	gif? ( media-libs/giflib
		media-libs/libungif )
	ggi? ( media-libs/libggi )
	gtk? (
		media-libs/libpng
		virtual/x11
		=x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2*
		)
	jpeg? ( media-libs/jpeg )
	libcaca? ( media-libs/libcaca )
	lirc? ( app-misc/lirc )
	lzo? ( dev-libs/lzo )
	mad? ( media-libs/libmad )
	matroska? ( >=media-libs/libmatroska-0.7.0 )
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
		live? ( >=media-plugins/live-2004.07.20 )
		)
	truetype? ( >=media-libs/freetype-2.1 )
	xinerama? ( virtual/x11 )
	jack? ( >=media-libs/bio2jack-0.3-r1 )
	xmms? ( media-sound/xmms )
	xanim? ( >=media-video/xanim-2.80.1-r4 )
	>=sys-apps/portage-2.0.36
	sys-libs/ncurses"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	app-arch/unzip"

SLOT="0"
LICENSE="GPL-2"
#KEYWORDS="~x86 ~ppc ~alpha ~amd64 ~ia64 ~hppa ~sparc"
#agriffis - uncomment this when ia64 is ready - Chris
KEYWORDS="~x86 ~ppc ~alpha ~amd64 ~hppa ~sparc ~ppc64"

src_unpack() {

	unpack MPlayer-${MY_PV}.tar.bz2 \
		font-arial-iso-8859-1.tar.bz2 font-arial-iso-8859-2.tar.bz2 \
		font-arial-cp1250.tar.bz2

	use svga && unpack svgalib_helper-${SVGV}-mplayer.tar.bz2

	use gtk && unpack Blue-${BLUV}.tar.bz2

	cd ${S}

	# Custom CFLAGS
	epatch ${FILESDIR}/${P}-configure.patch
	sed -e 's:CFLAGS="custom":CFLAGS=${CFLAGS}:' -i configure

	if use !network; then
		einfo "Please note, a new network USE flag was added for users"
		einfo "with networkless installs.  If you use mplayer for streaming"
		einfo "media, please enable the network USE flag or it will not work!"
		einfo
	fi

	# Fix head/tail call for new coreutils
	epatch ${FILESDIR}/${PN}-0.90-coreutils-fixup.patch

	#bug #49669, horrid syntax errors in help/help_mp-ro.h	
	epatch ${FILESDIR}/mplayer-1.0_pre4-help_mp-ro.h.patch

	#adds mythtv support to mplayer
	use mythtv && epatch ${FILESDIR}/mplayer-mythtv.patch

	# GCC 3.4 fixes
	epatch ${FILESDIR}/mplayer-1.0_pre4-alsa-gcc34.patch

	#Workaround for the altivec softscaler issues
	epatch ${FILESDIR}/mplayer-1.0_pre5-yuv2rgb_fix.patch

	#bug #55936, eradicator's cachefill patch.
	epatch ${FILESDIR}/cachefill.patch

	#bug #58082.  Fixes LANGUAGE variable issues
	epatch ${FILESDIR}/mplayer-1.0_pre5-r1-conf_locale.patch

	#fixes recent api changes to the latest live
	use live && epatch ${FILESDIR}/${P}-live.patch

	#mplayer gui uses oss all the time.
	#this patch enables true alsa output in
	#gmplayer.  Fixes Bug #58619.
	use alsa && epatch ${DISTDIR}/${P}-alsa-gui.patch.tar.bz2

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
	# Doesn't break if bio2jack is in
	epatch ${FILESDIR}/${P}-bio2jack.patch

	use ppc64 && epatch ${FILESDIR}/${P}-r4-ppc64.patch
}

linguas_warn() {
	ewarn "Language ${LANG[0]} or ${LANG_CC} not avaliable"
	ewarn "Language set to English"
	ewarn "If this is a mistake, please set the"
	ewarn "First LINGUAS language to one of the following"
	ewarn ""
	ewarn "bg - Bulgarian"
	ewarn "cz - Czech"
	ewarn "de - German"
	ewarn "dk - Swedish"
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

	# let's play the filtration game!  MPlayer hates on all!
	filter-flags -fPIE -fPIC -fstack-protector -fforce-addr -momit-leaf-frame-pointer -msse2 -falign-functions

	# ugly optimizations cause MPlayer to cry on x86 systems!
	if use x86 ; then
		replace-flags -O0 -O2
		replace-flags -O3 -O2
	fi

	local myconf=
	################
	#Optional features#
	###############
	myconf="${myconf} $(use_enable bidi fribidi)"
	myconf="${myconf} $(use_enable cdparanoia)"
	if use dvd; then
		myconf="${myconf} $(use_enable dvdread) $(use_enable !dvdread mpdvdkit)"
	else
		myconf="${myconf} --disable-dvdread --disable-mpdvdkit"
	fi
	myconf="${myconf} $(use_enable edl)"
	myconf="${myconf} $(use_enable encode mencoder)"
	myconf="${myconf} $(use_enable gtk gui)"

	if use !gtk && use !X && use !xv && use !xinerama; then
		myconf="${myconf} --disable-gui --disable-x11 --disable-xv --disable-xmga --disable-xinerama --disable-vm --disable-xvmc"
	else
		#note we ain't touching --enable-vm.  That should be locked down in the future.
		myconf="${myconf} --enable-x11 $(use_enable xinerama) $(use_enable xv) $(use_enable gtk gui)"
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
	if use ia64 || use !network; then
		myconf="${myconf} --disable-live"
	else
		myconf="${myconf} $(use_enable live)"
	fi
	myconf="${myconf} $(use_enable network) $(use_enable network ftp)"
	myconf="${myconf} $(use_enable rtc)"
	myconf="${myconf} $(use_enable samba smb)"
	myconf="${myconf} $(use_enable truetype freetype)"
	myconf="${myconf} $(use_enable v4l tv-v4l)"
	myconf="${myconf} $(use_enable v4l2 tv-v4l2)"
	myconf="${myconf} $(use_enable jack)"

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
	if use ia64; then
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
	myconf="${myconf} $(use_enable aalib aa)"
	myconf="${myconf} $(use_enable directfb)"
	myconf="${myconf} $(use_enable dvb)"
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
		myconf="${myconf} --disable-svga --disable-vidix"
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
			eerror ""
			eerror "Emerge again with different USE flags"

			exit 1
		}

	( use xvmc && ! use nvidia && ! use i8x0 ) && {
		ewarn "You tried to build with xvmc support."
		ewarn "No supported graphics hardware was specified."
		ewarn ""
		ewarn "No xvmc support will be included."
		ewarn "Please one appropriate USE flag and re-emerge:"
		ewarn "   nvidia or i8x0"

		myconf="${myconf} --disable-xvmc"
	}

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
	myconf="${myconf} $(use_enable 3dnow)"
	myconf="${myconf} $(use_enable 3dnowex)";
	myconf="${myconf} $(use_enable sse)"
	myconf="${myconf} $(use_enable mmx)"
	myconf="${myconf} $(use_enable mmx2)"
	myconf="${myconf} $(use_enable 3dnow)"
	myconf="${myconf} $(use_enable debug)"
	myconf="${myconf} $(use_enable nls i18n)"

	if use ppc64
	then
		myconf="${myconf} --disable-altivec"
	else
		myconf="${myconf} $(use_enable altivec)"
	fi

	if use real
	then
		if [ -d /usr/$(get_libdir)/real ]
		then
			REALLIBDIR="/usr/$(get_libdir)/real"
		else
			eerror "Real libs not found!  Install win32codecs"
			eerror "And ensure that real USE flag is enabled!"
			die "Real libs not found"
		fi
	fi

	if use xanim
	then
		myconf="${myconf} --with-xanimlibdir=/usr/lib/xanim/mods"
	fi

	if [ -e /dev/.devfsd ]
	then
		myconf="${myconf} --enable-linux-devfs"
	fi

	#leave this in place till the configure/compilation borkage is completely corrected back to pre4-r4 levels.
	# it's intended for debugging so we can get the options we configure mplayer w/, rather then hunt about.
	# it *will* be removed asap; in the meantime, doesn't hurt anything.
	echo "${myconf}" > ${T}/configure-options

	./configure \
		--prefix=/usr \
		--confdir=/usr/share/mplayer \
		--datadir=/usr/share/mplayer \
		--disable-runtime-cpudetection \
		--enable-largefiles \
		--enable-menu \
		--enable-real \
		--with-reallibdir=${REALLIBDIR} \
		--with-x11incdir=/usr/X11R6/include \
		${myconf} || die

	# when gif is autodetected, GIF_LIB is set correctly.  We're explicitly controlling it, and it doesn't behave correctly.
	# so... we have to help it along.
	if use gif; then
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
	for x in $(find ${WORKDIR}/ -type d -name 'font-arial-*')
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
		einfo "For those using alsa, please note the vo driver name is no longer"
		einfo "alsa9x or alsa1x.  It is now just 'alsa' (omit quotes)."
		einfo "The syntax for optional drivers has also changed.  For example"
		einfo "if you use a dmix driver called 'dmixer,' use"
		einfo "vo=alsa:device=dmixer instead of vo=alsa:dmixer"
		einfo "Some users may not need to specify the extra driver with the vo="
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

