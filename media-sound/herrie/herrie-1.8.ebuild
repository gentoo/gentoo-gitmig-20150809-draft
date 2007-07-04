# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/herrie/herrie-1.8.ebuild,v 1.2 2007/07/04 20:27:48 gustavoz Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Herrie is a command line music player."
HOMEPAGE="http://herrie.info/"
SRC_URI="http://herrie.info/distfiles/${P}.tar.bz2"

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="ao http modplug mp3 sndfile vorbis xspf unicode nls pulseaudio oss
	linguas_de linguas_nl linguas_pl linguas_tr linguas_sv linguas_ga"

DEPEND="sys-libs/ncurses
	>=dev-libs/glib-2.0
	media-libs/alsa-lib
	ao? ( media-libs/libao )
	http? ( net-misc/curl )
	modplug? ( media-libs/libmodplug )
	mp3? ( media-libs/libmad
		media-libs/libid3tag )
	pulseaudio? ( media-sound/pulseaudio )
	sndfile? ( media-libs/libsndfile )
	vorbis? ( media-libs/libvorbis )
	xspf? ( >=media-libs/libspiff-0.6.5 )"
RDEPEND="${DEPEND}"
DEPEND="sys-devel/gettext
	dev-util/pkgconfig"

pkg_setup() {
	if use unicode && ! built_with_use sys-libs/ncurses unicode; then
		echo
		eerror "Rebuild sys-libs/ncurses with USE=unicode if you need unicode in herrie."
		die "Rebuild sys-libs/ncurses with USE=unicode if you need unicode in herrie."
	fi
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	epatch "${FILESDIR}/${P}-chost.patch"
}

src_compile() {
	# We could add coreaudio here if on osx
	local EXTRA_CONF="verbose no_strip alsa"
	use ao && EXTRA_CONF="${EXTRA_CONF} ao"
	use http || EXTRA_CONF="${EXTRA_CONF} no_http no_scrobbler"
	use mp3 || EXTRA_CONF="${EXTRA_CONF} no_mp3"
	use modplug || EXTRA_CONF="${EXTRA_CONF} no_modplug"
	use nls || EXTRA_CONF="${EXTRA_CONF} no_nls"
	use oss && EXTRA_CONF="${EXTRA_CONF} oss"
	use pulseaudio && EXTRA_CONF="${EXTRA_CONF} pulse"
	use sndfile || EXTRA_CONF="${EXTRA_CONF} no_sndfile"
	use unicode || EXTRA_CONF="${EXTRA_CONF} ncurses"
	use vorbis || EXTRA_CONF="${EXTRA_CONF} no_vorbis"
	use xspf || EXTRA_CONF="${EXTRA_CONF} no_xspf"

	einfo "./configure ${EXTRA_CONF}"
	CC="$(tc-getCC)" PREFIX=/usr MANDIR=/usr/share/man \
		./configure ${EXTRA_CONF} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README ChangeLog
}
