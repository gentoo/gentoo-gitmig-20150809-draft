# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.10-r1.ebuild,v 1.4 2004/04/04 00:54:50 eradicator Exp $

inherit flag-o-matic eutils

PATCHVER="0.3"

MY_P=${P/_pre/-pre}
S=${WORKDIR}/${MY_P}

DESCRIPTION="X MultiMedia System"
HOMEPAGE="http://www.xmms.org/"
SRC_URI="http://www.xmms.org/files/1.2.x/${MY_P}.tar.bz2
	mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2
	http://dev.gentoo.org/~eradicator/xmms/${P}-gentoo-patches-${PATCHVER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~alpha hppa ~amd64 ~ia64"
IUSE="xml nls esd opengl mmx oggvorbis 3dnow mikmod directfb ipv6 cjk alsa"

DEPEND="=x11-libs/gtk+-1.2*
	mikmod? ( >=media-libs/libmikmod-3.1.10 )
	esd? ( >=media-sound/esound-0.2.22 )
	xml? ( >=dev-libs/libxml-1.8.15 )
	opengl? ( virtual/opengl )
	alsa? ( >=media-libs/alsa-lib-0.9.0 )
	!media-plugins/xmms-alsa
	oggvorbis? ( >=media-libs/libvorbis-1.0 )"

RDEPEND="${DEPEND}
	directfb? ( dev-libs/DirectFB )
	app-arch/unzip"

#We want these things in DEPEND only
DEPEND="${DEPEND}
	nls? ( dev-util/intltool )
	>=sys-devel/automake-1.7.8
	>=sys-devel/autoconf-2.58"

PATCHDIR=${WORKDIR}/patches

src_unpack() {
	unpack ${A}
	cd ${S}

	# Add dynamic taste detection patch...
	# goto http://bugs.xmms.org/show_bug.cgi?id=756 to vote for its inclusion in mainline xmms
	# Newer dtd code uses a balanced tree... Uncomment llist one to tr older version.  Leaving in
	# until tested.
	# epatch ${PATCHDIR}/${P}-dtd-llist.patch
	epatch ${PATCHDIR}/${P}-dtd-baltree.patch

	# Fix ansi C fubar so that it compiles with less-forgiving gcc2
	epatch ${PATCHDIR}/${P}-id3v2edit.patch

	# Patch to allow external programmes to have the "jump to" dialog box
	epatch ${PATCHDIR}/${P}-jump.patch

	# Save playlist, etc on SIGTERM and SIGINT, bug #13604.
	epatch ${PATCHDIR}/${P}-sigterm.patch

	# Patch for mpg123 to convert Japanese character code of MP3 tag info
	# the Japanese patch and the Russian one overlap, so its one or the other
	if use cjk; then
		epatch ${PATCHDIR}/${P}-mpg123j.patch
	else
		# add recode patch http://sourceforge.net/projects/rusxmms/
		epatch ${PATCHDIR}/${P}-recode-csa27.patch
		epatch ${PATCHDIR}/${P}-recode-csa27.gcc2.patch
	fi

	if [ ! -f ${S}/config.rpath ] ; then
		touch ${S}/config.rpath
		chmod +x ${S}/config.rpath
	fi

	# Add /usr/local/share/xmms/Skins to the search path for skins
	epatch ${PATCHDIR}/${P}-fhs-skinsdir.patch

	# This patch passes audio output through the output plugin
	# before recording via the diskwriter plugin
	# http://forum.xmms.org/viewtopic.php?t=500&sid=c286e1c01fb924a2f81f519969f33764
	epatch ${PATCHDIR}/${P}-diskwriter-audio.patch

	# Patch to enable superior randomised playlists:
	epatch ${PATCHDIR}/${P}-random.patch

	# This patch changes the search-bar's behaviour when playing
	# sid tunes using xmms-sid plugin. It enables you to select the
	# different tunes that are sometimes included in a single .sid file
	epatch ${PATCHDIR}/${P}-sid-songpos.patch

	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7
	for x in . libxmms ; do
		cd ${S}/${x}

		ebegin "Running aclocal in ${S}/${x}"
		aclocal
		eend $?

		ebegin "Running automake in ${S}/${x}"
		automake --gnu --add-missing --include-deps
		retval=$?
		eend $retval

		if [ $retval -ne 0 ]; then
			exit 1;
		fi
	done
}

src_compile() {
	filter-flags -fforce-addr -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE

	local myconf=""

	# Allow configure to detect mipslinux systems
	use mips && gnuconfig_update

	if use amd64; then
		myconf="${myconf} --disable-simd"
	else
	  	if use 3dnow || use mmx; then
			myconf="${myconf} --enable-simd"
		else
			myconf="${myconf} --disable-simd"
		fi
	fi

	use xml || myconf="${myconf} --disable-cdindex"

	econf \
		--with-dev-dsp=/dev/sound/dsp \
		--with-dev-mixer=/dev/sound/mixer \
		`use_enable oggvorbis vorbis` \
		`use_enable oggvorbis oggtest` \
		`use_enable oggvorbis vorbistest` \
		`use_enable esd` \
		`use_enable esd esdtest` \
		`use_enable mikmod` \
		`use_enable mikmod mikmodtest` \
		`use_with mikmod libmikmod` \
		`use_enable opengl` \
		`use_enable nls` \
		`use_enable ipv6` \
		${myconf} \
		|| die

	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog FAQ NEWS README TODO

	keepdir /usr/share/xmms/Skins
	insinto /usr/share/pixmaps/
	donewins xmms/xmms_logo.xpm xmms.xpm
	doins xmms/xmms_logo.xpm
	insinto /usr/share/pixmaps/mini
	doins xmms/xmms_mini.xpm

	insinto /etc/X11/wmconfig
	donewins xmms/xmms.wmconfig xmms

	insinto /usr/share/gnome/apps/Multimedia
	doins ${FILESDIR}/xmms.desktop
	insinto /usr/share/applnk/Multimedia
	doins ${FILESDIR}/xmms.desktop
	insinto /usr/share/applications
	doins ${FILESDIR}/xmms.desktop

	# Add the sexy Gentoo Ice skin
	insinto /usr/share/xmms/Skins/gentoo_ice
	doins ${WORKDIR}/gentoo_ice/*
	docinto gentoo_ice
	dodoc ${WORKDIR}/README
}

pkg_postinst() {
	echo
	einfo "If you have been using the xmms-sid plugin before,"
	einfo "it would be a good idea to re-emerge it now, to have"
	einfo "the additional features introduced by the xmms-songpos patch"
	einfo "which let's you select one of several tunes sometimes included"
	einfo "in a single .sid file using the song-position slider."
	echo
	einfo "If you enjoy the dtd (Dynamic Taste Detection) patch, please"
	einfo "visit the url below and vote for this patch's inclusion in"
	einfo "main-line xmms."
	einfo "http://bugs.xmms.org/show_bug.cgi?id=756"
}
