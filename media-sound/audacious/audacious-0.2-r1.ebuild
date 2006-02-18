# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacious/audacious-0.2-r1.ebuild,v 1.2 2006/02/18 21:59:22 chainsaw Exp $

IUSE="aac alsa esd flac gnome jack libvisual lirc mmx modplug mp3 musepack nls oss sdl sid sndfile vorbis wma"

inherit flag-o-matic eutils

DESCRIPTION="Audacious Player - Your music, your way, no exceptions."
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://audacious-media-player.org/release/${P}.tgz
	mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND="app-arch/unzip
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2.3.1
	>=dev-cpp/libbinio-1.4
	alsa? ( >=media-libs/alsa-lib-1.0.9_rc2 )
	esd? ( >=media-sound/esound-0.2.30 )
	flac? ( >=media-libs/libvorbis-1.0
		>=media-libs/flac-1.1.2 )
	gnome? ( >=gnome-base/gconf-2.6.0 )
	jack? ( >=media-libs/bio2jack-0.4
		media-libs/libsamplerate
		media-sound/jack-audio-connection-kit )
	libvisual? ( =media-plugins/libvisual-plugins-0.2.0
		     >=media-libs/libsdl-1.2.5 )
	lirc? ( app-misc/lirc )
	modplug? ( media-libs/libmodplug )
	musepack? ( media-libs/libmpcdec )
	mp3? ( media-libs/id3lib )
	sid? ( media-libs/libsidplay )
	sndfile? ( media-libs/libsndfile )
	vorbis? ( >=media-libs/libvorbis-1.0
		  >=media-libs/libogg-1.0 )"

DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )
	>=dev-util/pkgconfig-0.9.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-no-sigabrt-on-null-path.diff
	epatch ${FILESDIR}/${PV}-thumbnail.diff
	epatch ${FILESDIR}/${PV}-segfault.diff
}

src_compile() {
	if ! useq mp3; then
		ewarn "MP3 support is now optional and you have not enabled it."
	fi

	# Bug #42893
	replace-flags "-Os" "-O2"
	# Bug #86689
	is-flag "-O*" || append-flags -O

	econf \
		--with-dev-dsp=/dev/sound/dsp \
		--with-dev-mixer=/dev/sound/mixer \
		--includedir=/usr/include/audacious \
		`use_enable mmx simd` \
		`use_enable gnome gconf` \
		`use_enable vorbis` \
		`use_enable esd` \
		`use_enable mp3` \
		`use_enable nls` \
		`use_enable oss` \
		`use_enable alsa` \
		`use_enable flac` \
		`use_enable aac` \
		`use_enable modplug` \
		`use_enable lirc` \
		`use_enable sndfile` \
		`use_enable wma` \
		`use_enable sid` \
		`use_enable musepack` \
		`use_enable jack` \
		|| die

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS FAQ NEWS README

	# Gentoo_ice skin installation; bug #109772
	insinto /usr/share/audacious/Skins/gentoo_ice
	doins ${WORKDIR}/gentoo_ice/*
	docinto gentoo_ice
	dodoc ${WORKDIR}/README

	# XMMS skin symlinking; bug 70697
	for SKIN in /usr/share/xmms/Skins/* ; do
		dosym "$SKIN" /usr/share/audacious/Skins/
	done
}

pkg_postinst() {
	echo
	einfo "Your XMMS skins, if any, have been symlinked."
	einfo "MP3 support is now optional, you may want to enable the mp3 USE-flag."
	echo
}
