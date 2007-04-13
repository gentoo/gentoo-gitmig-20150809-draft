# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/herrie/herrie-1.5.1.ebuild,v 1.2 2007/04/13 09:18:45 rbu Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Herrie is a command line music player."
HOMEPAGE="http://herrie.info/"
SRC_URI="http://g-rave.nl/projects/herrie/distfiles/${P}.tar.gz"

LICENSE="BSD-2 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ao http modplug mp3 scrobbler sdl sndfile vorbis linguas_nl linguas_tr"

DEPEND="sys-libs/ncurses
	>=dev-libs/glib-2.0
	ao? ( media-libs/libao )
	http? ( net-misc/curl )
	modplug? ( media-libs/libmodplug )
	mp3? ( media-libs/libmad
		media-libs/libid3tag )
	scrobbler? ( net-misc/curl
		dev-libs/openssl )
	sdl? ( media-libs/libsdl )
	sndfile? ( media-libs/libsndfile )
	vorbis? ( media-libs/libvorbis )"
RDEPEND="${DEPEND}"
DEPEND="sys-devel/gettext"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	epatch "${FILESDIR}/${P}-chost.patch"
	epatch "${FILESDIR}/${P}-gnu-source-define.patch"
}

src_compile() {
	if ! use vorbis && ! use mp3 && ! use modplug && ! use sndfile ; then
		die "You need to enable at least one audio output (USE must contain any of modplug, mp3, sndfile, vorbis)."
	fi

	local EXTRA_CONF=""
	use ao && EXTRA_CONF="${EXTRA_CONF} ao"
	use http || EXTRA_CONF="${EXTRA_CONF} no_http"
	use mp3 || EXTRA_CONF="${EXTRA_CONF} no_mp3"
	use modplug || EXTRA_CONF="${EXTRA_CONF} no_modplug"
	use scrobbler || EXTRA_CONF="${EXTRA_CONF} no_scrobbler"
	use sdl && EXTRA_CONF="${EXTRA_CONF} sdl"
	use sndfile || EXTRA_CONF="${EXTRA_CONF} no_sndfile"
	use vorbis || EXTRA_CONF="${EXTRA_CONF} no_vorbis"

	CC="$(tc-getCC)" PREFIX=/usr MANDIR=/usr/share/man ./configure ${EXTRA_CONF} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	dobin herrie
	doman herrie.1

	dodoc README ChangeLog

	insinto /etc
	newins herrie.conf.sample herrie.conf

	use linguas_nl && domo nl.mo
	use linguas_tr && domo tr.mo
}
