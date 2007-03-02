# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/audacious-plugins/audacious-plugins-1.3.0.ebuild,v 1.1 2007/03/02 16:43:34 chainsaw Exp $

inherit eutils flag-o-matic autotools

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://static.audacious-media-player.org/release/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="aac adplug alsa arts chardet esd flac jack lirc mad modplug musepack nls opengl oss sid sndfile timidity tta vorbis wavpack wma pulseaudio"

RDEPEND="app-arch/unzip
	dev-libs/libxml2
	media-libs/libsamplerate
	net-misc/curl
	>=media-sound/audacious-1.3.0
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2.3.1
	>=media-libs/libsdl-1.2.5
	media-libs/taglib
	adplug? ( >=dev-cpp/libbinio-1.4 )
	alsa? ( >=media-libs/alsa-lib-1.0.9_rc2 )
	arts? ( kde-base/arts )
	esd? ( >=media-sound/esound-0.2.30 )
	flac? ( >=media-libs/libvorbis-1.0
		|| ( ~media-libs/flac-1.1.2
		     ~media-libs/flac-1.1.3 )
	      )
	jack? ( >=media-libs/bio2jack-0.4
		media-libs/libsamplerate
		media-sound/jack-audio-connection-kit )
	lirc? ( app-misc/lirc )
	mad? ( media-libs/libmad )
	musepack? ( media-libs/libmpcdec )
	opengl? ( =media-libs/libprojectm-0.99* )
	sid? ( media-libs/libsidplay )
	sndfile? ( media-libs/libsndfile )
	timidity? ( media-sound/timidity++ )
	tta? ( media-libs/libid3tag )
	vorbis? ( >=media-libs/libvorbis-1.0
		  >=media-libs/libogg-1.0 )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.3 )
	wavpack? ( >=media-sound/wavpack-4.31 )
	wma? ( >=media-libs/libmms-0.3 )"

DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )
	>=dev-util/pkgconfig-0.9.0
	!media-plugins/audacious-docklet"

mp3_warning() {
	if ! useq mad ; then
		echo
		ewarn "MP3 support is optional, you may want to enable the mad USE-flag"
		echo
	fi
}

src_compile() {
	mp3_warning

	# Bug #42893
	replace-flags "-Os" "-O2"
	# Bug #86689
	is-flag "-O*" || append-flags -O

	econf \
		--with-dev-dsp=/dev/sound/dsp \
		--with-dev-mixer=/dev/sound/mixer \
		--enable-paranormal \
		$(use_enable vorbis) \
		$(use_enable esd) \
		$(use_enable mad mp3) \
		$(use_enable nls) \
		$(use_enable oss) \
		$(use_enable alsa) \
		$(use_enable arts) \
		$(use_enable flac) \
		$(use_enable aac) \
		$(use_enable modplug) \
		$(use_enable lirc) \
		$(use_enable sndfile) \
		$(use_enable wma) \
		$(use_enable sid) \
		$(use_enable musepack) \
		$(use_enable jack) \
		$(use_enable timidity) \
		$(use_enable pulseaudio pulse) \
		$(use_enable chardet) \
		$(use_enable wavpack) \
		$(use_enable tta) \
		$(use_enable opengl projectm) \
		$(use_enable adplug) \
		|| die

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS
}

pkg_postinst() {
	mp3_warning
	elog "Note that you need to recompile *all* third-party plugins to use Audacious 1.3 builds."
	elog "To clarify, that means all plugins *not* contained in this ebuild. Failure to do so may cause "
	elog "the player to crash. Rebuild, and if that fails, unmerge, any third-party plugins before you "
	elog "report a bug."
}
