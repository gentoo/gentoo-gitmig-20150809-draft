# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/xine-lib/xine-lib-1_rc3.ebuild,v 1.1 2003/12/17 23:13:28 mholzer Exp $

inherit eutils flag-o-matic

# this build doesn't play nice with -maltivec (gcc 3.2 only option) on ppc
# Commenting this out in this ebuild, because CFLAGS and CXXFLAGS are unset
# at make time any way.
# Brandon Low (29 Apr 2003)
# inherit flag-o-matic
filter-flags "-maltivec -mabi=altivec"
# replace-flags k6-3 i686
# replace-flags k6-2 i686
# replace-flags k6   i686

#fix build errors with -march/mcpu=pentium4
if [ "$COMPILER" == "gcc3" ]; then
	if [ -n "`is-flag -march=pentium4`" -o -n "`is-flag -mcpu=pentium4`" ]; then
		append-flags -mno-sse2
	fi
fi

#13 Jul 2003: drobbins: build failure using -j5 on a dual Xeon in 1_beta12
MAKEOPTS="$MAKEOPTS -j1"

# This should normally be empty string, unless a release has a suffix.
MY_PKG_SUFFIX=""

DESCRIPTION="Core libraries for Xine movie player"
HOMEPAGE="http://xine.sourceforge.net/"
SRC_URI="mirror://sourceforge/xine/${PN}-${PV/_/-}${MY_PKG_SUFFIX}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~x86 ~ppc ~hppa ~sparc ~amd64"
IUSE="arts esd avi nls dvd aalib X directfb oggvorbis alsa gnome sdl"

RDEPEND="oggvorbis? ( media-libs/libvorbis )
	X? ( virtual/x11 )
	avi? ( x86? ( >=media-libs/win32codecs-0.50
	       media-libs/divx4linux ) )
	esd? ( media-sound/esound )
	dvd? ( >=media-libs/libdvdcss-1.2.7 )
	arts? ( kde-base/arts )
	alsa? ( media-libs/alsa-lib )
	aalib? ( media-libs/aalib )
	directfb? ( >=dev-libs/DirectFB-0.9.9
		    dev-util/pkgconfig )
	gnome? ( >=gnome-base/gnome-vfs-2.0
			dev-util/pkgconfig )
	>=media-libs/flac-1.0.4
	sdl? ( >=media-libs/libsdl-1.1.5 )
	>=media-libs/libfame-0.9.0
	>=media-libs/xvid-0.9.0
	media-libs/speex"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

#sys-devel/gcc-3.2 fixes -march=pentium4 compile issue

S=${WORKDIR}/${PN}-${PV/_/-}${MY_PKG_SUFFIX}

src_unpack() {

	unpack ${A}

	# gcc2 fixes provided by <T.Henderson@cs.ucl.ac.uk> in #26534
	#epatch ${FILESDIR}/${P}-gcc2_fix.patch
	# preserve CFLAGS added by drobbins, -O3 isn't as good as -O2 most of the time
	epatch ${FILESDIR}/protect-CFLAGS.patch-${PV} || die
}

src_compile() {
	# Make sure that the older libraries are not installed (bug #15081).
	if [ -f /usr/lib/libxine.so.0 ]
	then
		einfo "Please uninstall older xine libraries.";
		einfo "The compilation cannot proceed.";
		die
	fi

	# Use the built-in dvdnav plugin.
	local myconf="--with-included-dvdnav"

	# Most of these are not working currently, but are here for completeness
	# don't use the --disable-XXXtest because that defaults to ON not OFF
	use X \
		|| myconf="${myconf} --disable-x11"
	use esd	\
		|| myconf="${myconf} --disable-esd"
	use nls	\
		|| myconf="${myconf} --disable-nls"
	use alsa \
		|| myconf="${myconf} --disable-alsa"
	use arts \
		|| myconf="${myconf} --disable-arts"
	use aalib \
		|| myconf="${myconf} --disable-aalib"
	use oggvorbis \
		|| myconf="${myconf} --disable-ogg --disable-vorbis"

	use avi	\
		&& myconf="${myconf} --with-w32-path=/usr/lib/win32" \
		|| myconf="${myconf} --disable-asf"
	use sdl \
		|| myconf="${myconf} --with-sdl-prefix=/null"

	econf ${myconf} || die "Configure failed"

	emake || die "Parallel make failed"
}

src_install() {
	einstall || die "Install failed"

	# Xine's makefiles install some file incorrectly. (Gentoo bug #8583, #16112).
	dodir /usr/share/xine/libxine1/fonts
	mv ${D}/usr/share/*.xinefont.gz ${D}/usr/share/xine/libxine1/fonts/

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
	cd ${S}/doc
	dodoc dataflow.dia README*
}

pkg_postinst() {
	einfo
	einfo "Please note, a new version of xine-lib has been installed,"
	einfo "for library consistency you need to unmerge old versions"
	einfo "of xine-lib before merging xine-ui."
	einfo
	einfo "This library version 1 is incompatible with the plugins,"
	einfo "designed for the prior library versions (such as xine-d4d,"
	einfo "xine-d5d, xine-dmd, and xine-dvdnav."
	einfo
	einfo "Also make sure to remove your ~/.xine if upgrading from"
	einfo "a previous version."
	einfo
}
