# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.8-r4.ebuild,v 1.2 2004/02/03 09:48:55 eradicator Exp $

IUSE="xml nls esd gnome opengl mmx oggvorbis 3dnow mikmod directfb ipv6 cjk"

inherit flag-o-matic eutils
filter-flags -fforce-addr -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE

PATCHVER="0.2"

DESCRIPTION="X MultiMedia System"
HOMEPAGE="http://www.xmms.org/"
SRC_URI="http://www.xmms.org/files/1.2.x/${P}.tar.bz2
	mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2
	mirror://gentoo/${P}-gentoo-patches-${PATCHVER}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~sparc ~alpha ~hppa ~mips amd64 ~ia64"

DEPEND="=x11-libs/gtk+-1.2*
	mikmod? ( >=media-libs/libmikmod-3.1.10 )
	esd? ( >=media-sound/esound-0.2.22 )
	xml? ( >=dev-libs/libxml-1.8.15 )
	!gtk2? ( gnome? ( <gnome-base/gnome-panel-1.5.0 ) )
	opengl? ( virtual/opengl )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )"

RDEPEND="${DEPEND}
	directfb? ( dev-libs/DirectFB )
	nls? ( dev-util/intltool )
	app-arch/unzip"

#We want these things in DEPEND only
DEPEND="$DEPEND
	>=sys-devel/automake-1.7.8
	>=sys-devel/autoconf-2.58"

PATCHDIR=${WORKDIR}/patches

src_unpack() {
	unpack ${A}
	cd ${S}

	# Add dynamic taste detection patch
	epatch ${PATCHDIR}/${P}-dtd.patch

	# Remove alsa debug messages
	epatch ${PATCHDIR}/${P}-alsafix.patch

	# Patch to allow external programmes to have the "jump to" dialog box
	epatch ${PATCHDIR}/${P}-jump.patch

	# Save playlist, etc on SIGTERM and SIGINT, bug #13604.
	epatch ${PATCHDIR}/${P}-sigterm.patch

	#shadow Patch, bug #30420.
	epatch ${PATCHDIR}/${P}-shadow.patch

	# Patch for mpg123 to convert Japanese character code of MP3 tag info
	# the Japanese patch and the Russian one overlap, so its one or the other
	if use cjk; then
		epatch ${PATCHDIR}/${P}-mpg123j.patch
	else
		# add russian charset support
		epatch ${PATCHDIR}/${P}-russian-charset-csa20.patch
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
	for x in . libxmms ; do
		cd ${S}/${x}
		automake --gnu --add-missing --include-deps || die
	done
}

src_compile() {
	local myconf=""

	# Allow configure to detect mipslinux systems
	use mips && gnuconfig_update

	if [ `use amd64` ]; then
		myconf="${myconf} --disable-simd"
	else
	  	if [ `use 3dnow` ] || [ `use mmx` ] ; then
			myconf="${myconf} --enable-simd"
		else
			myconf="${myconf} --disable-simd"
		fi
	fi

	use xml || myconf="${myconf} --disable-cdindex"

	econf \
		--with-dev-dsp=/dev/sound/dsp \
		--with-dev-mixer=/dev/sound/mixer \
		`use_with gnome` \
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

	### emake seems to break some compiles, please keep @ make
	make || die
}

src_install() {
	einstall \
		incdir=${D}/usr/include \
		sysdir=${D}/usr/share/applets/Multimedia \
		GNOME_SYSCONFDIR=${D}/etc \
		install || die "make install failed"

	dodoc AUTHORS ChangeLog COPYING FAQ NEWS README TODO

	keepdir /usr/share/xmms/Skins
	insinto /usr/share/pixmaps/
	donewins gnomexmms/gnomexmms.xpm xmms.xpm
	doins xmms/xmms_logo.xpm
	insinto /usr/share/pixmaps/mini
	doins xmms/xmms_mini.xpm

	insinto /etc/X11/wmconfig
	donewins xmms/xmms.wmconfig xmms

	if [ `use gnome` ] ; then
		insinto /usr/share/gnome/apps/Multimedia
		doins xmms/xmms.desktop
		dosed "s:xmms_mini.xpm:mini/xmms_mini.xpm:" \
			/usr/share/gnome/apps/Multimedia/xmms.desktop
	else
		rm ${D}/usr/share/man/man1/gnomexmms*
	fi

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
