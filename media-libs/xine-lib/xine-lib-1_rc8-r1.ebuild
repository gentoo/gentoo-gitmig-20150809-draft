# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/xine-lib/xine-lib-1_rc8-r1.ebuild,v 1.16 2005/01/04 17:41:02 chriswhite Exp $

inherit eutils flag-o-matic gcc libtool

# This should normally be empty string, unless a release has a suffix.
MY_PKG_SUFFIX=""

DESCRIPTION="Core libraries for Xine movie player"
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="mirror://sourceforge/xine/${PN}-${PV/_/-}${MY_PKG_SUFFIX}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 ~sparc x86 mips"
IUSE="arts esd avi nls dvd aalib X directfb oggvorbis alsa gnome sdl speex theora ipv6 altivec xv pic"

RDEPEND="oggvorbis? ( media-libs/libvorbis )
	!amd64? ( X? ( virtual/x11 ) )
	amd64? ( X? ( || ( x11-base/xorg-x11 >=x11-base/xfree-4.3.0-r6 ) ) )
	avi? ( x86? ( >=media-libs/win32codecs-0.50 ) )
	esd? ( media-sound/esound )
	dvd? ( >=media-libs/libdvdcss-1.2.7 )
	arts? ( kde-base/arts )
	alsa? ( media-libs/alsa-lib )
	aalib? ( media-libs/aalib )
	directfb? ( >=dev-libs/DirectFB-0.9.9 dev-util/pkgconfig )
	gnome? ( >=gnome-base/gnome-vfs-2.0
			dev-util/pkgconfig )
	>=media-libs/flac-1.0.4
	sdl? ( >=media-libs/libsdl-1.1.5 )
	>=media-libs/libfame-0.9.0
	theora? ( media-libs/libtheora )
	speex? ( media-libs/speex )"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7
	>=sys-devel/autoconf-2.59
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}-${PV/_/-}${MY_PKG_SUFFIX}

pkg_setup() {
	# Make sure that the older libraries are not installed (bug #15081).
	if [ `has_version =media-libs/xine-lib-0.9.13*` ]
	then
		eerror "Please uninstall older xine libraries.";
		eerror "The compilation cannot proceed.";
		die
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# plasmaroo: Kernel 2.6 headers patch
	epatch ${FILESDIR}/${PN}-1_rc7-2.6.patch

	# fixes #74475 security bug
	epatch ${FILESDIR}/djb_demux_aiff.patch

	# fixes bad X11 directories
	epatch ${FILESDIR}/${PN}-x11.patch

	# fixes bad xv checking
	epatch ${FILESDIR}/${P}-configure.ac.patch

	# Fix building on amd64, #49569
	#use amd64 && epatch ${FILESDIR}/configure-64bit-define.patch

	use pic && epatch ${FILESDIR}/${PN}-1_rc7-pic.patch
	if use pic && use x86
	then
		epatch ${FILESDIR}/${PN}-hardened-mmx.patch
	fi

	# Fix detection of hppa2.0 and hppa1.1 CHOST
	use hppa && sed -e 's/hppa-/hppa*-linux-/' -i ${S}/configure.ac

	# Fix detection of sparc64 systems
	use sparc && epatch ${FILESDIR}/xine-lib-1_rc7-configure-sparc.patch

	# Makefile.ams and configure.ac get patched, so we need to rerun
	# autotools
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7
	aclocal -I m4
	libtoolize --copy --force
	autoheader
	automake -a -f -c
	autoconf
}

src_compile() {
	filter-flags -maltivec -mabi=altivec
	filter-flags -fforce-addr
	filter-flags -momit-leaf-frame-pointer #46339
	filter-flags -funroll-all-loops #55420

	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]; then
		append-flags -fno-web #49509
		filter-flags -fno-unit-at-a-time #55202
		append-flags -funit-at-a-time #55202
	fi

	is-flag -O? || append-flags -O1 #31243

	# fix build errors with sse2 #49482
	if use x86 ; then
		if [ `gcc-major-version` -eq 3 ] ; then
			append-flags -mno-sse2 `test_flag -mno-sse3`
			filter-mfpmath sse
		fi
	fi

	# Use the built-in dvdnav plugin.
	local myconf="--with-included-dvdnav"

	# the win32 codec path should ignore $(get_libdir) and always use lib
	use avi	&& use x86 \
		&& myconf="${myconf} --with-w32-path=/usr/$(get_libdir)/win32" \
		|| myconf="${myconf} --disable-asf"

	use sparc \
		&& myconf="${myconf} --build=${CHOST}"

	# enable/disable appropiate optimizations on sparc
	[ "${PROFILE_ARCH}" == "sparc64" -o "${PROFILE_ARCH}" == "sparc64-multilib" ] \
		&& myconf="${myconf} --enable-vis"
	[ "${PROFILE_ARCH}" == "sparc" ] \
		&& myconf="${myconf} --disable-vis"

	# Adding extra logic here to deal with newer xorg-x11 ebuilds
	if use xv; then
		if [ -f "${ROOT}/usr/$(get_libdir)/libXv.so" ]; then
			myconf="${myconf} --enable-shared-xv --with-xv-path=${ROOT}/usr/$(get_libdir)"
		elif [ -f "${ROOT}/usr/$(get_libdir)/libXv.a" ]; then
			myconf="${myconf} --enable-static-xv --with-xv-path=${ROOT}/usr/$(get_libdir)"
		elif [ -f "${ROOT}/usr/X11R6/$(get_libdir)/libXv.so" ]; then
			myconf="${myconf} --enable-shared-xv --with-xv-path=${ROOT}/usr/X11R6/$(get_libdir)"
		elif [ -f "${ROOT}/usr/X11R6/$(get_libdir)/libXv.a" ]; then
			myconf="${myconf} --enable-static-xv --with-xv-path=${ROOT}/usr/X11R6/$(get_libdir)"
		else
			myconf="${myconf} --enable-shared-xv"
		fi
	fi

	# Fix compilation-errors on PowerPC #45393 & #55460 & #68251
	if use ppc || use ppc64 ; then
		append-flags -U__ALTIVEC__
		myconf="${myconf} `use_enable altivec`"
	fi

	# The default CFLAGS (-O) is the only thing working on hppa.
	if use hppa && [ "`gcc-version`" != "3.4" ] ; then
		unset CFLAGS
	else
		append-flags -ffunction-sections
	fi

	# if lib64 is a directory, sometimes the configure will set libdir itself
	# and the installation fails. see bug #62339
	myconf="${myconf} --libdir=/usr/$(get_libdir)"

	econf \
		$(use_enable X x11) \
		$(use_with X x) \
		$(use_enable X shm) \
		$(use_enable X xft)  \
		$(use_enable esd) \
		$(use_enable nls) \
		$(use_enable alsa) \
		$(use_enable arts) \
		$(use_enable aalib) \
		$(use_enable oggvorbis ogg) \
		$(use_enable oggvorbis vorbis) \
		$(use_enable sdl sdltest) \
		$(use_enable ipv6) \
		$(use_enable directfb) \
		${myconf} || die "Configure failed"

	emake -j1 || die "Parallel make failed"
}

src_install() {
	# portage 2.0.50's einstall is broken for handling libdir
	make DESTDIR=${D} install || die "Install failed"

	# Xine's makefiles install some file incorrectly. (Gentoo bug #8583, #16112).
	dodir /usr/share/xine/libxine1/fonts
	mv ${D}/usr/share/*.xinefont.gz ${D}/usr/share/xine/libxine1/fonts/

	dodoc AUTHORS ChangeLog INSTALL README TODO
	cd ${S}/doc
	dodoc dataflow.dia README*
}

pkg_postinst() {
	einfo
	einfo "Please note, a new version of xine-lib has been installed."
	einfo "For library consistency, you need to unmerge old versions"
	einfo "of xine-lib before merging xine-ui."
	einfo
	einfo "This library version 1 is incompatible with the plugins"
	einfo "designed for the prior library versions such as xine-d4d,"
	einfo "xine-d5d, xine-dmd, and xine-dvdnav."
	einfo
	einfo "Also, make sure to remove your ~/.xine if upgrading from"
	einfo "a previous version."
	einfo
}
