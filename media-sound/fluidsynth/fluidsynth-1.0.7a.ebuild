# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/fluidsynth/fluidsynth-1.0.7a.ebuild,v 1.7 2008/05/24 17:08:40 josejx Exp $

inherit flag-o-matic eutils libtool

IUSE="alsa debug jack ladspa lash oss"

DESCRIPTION="Fluidsynth is a software real-time synthesizer based on the Soundfont 2 specifications."
HOMEPAGE="http://www.fluidsynth.org/"
SRC_URI="http://savannah.nongnu.org/download/fluid/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86 ~x86-fbsd"

DEPEND="jack? ( media-sound/jack-audio-connection-kit )
	ladspa? ( >=media-libs/ladspa-sdk-1.12
			  >=media-libs/ladspa-cmt-1.15 )
	alsa? ( media-libs/alsa-lib
			lash? ( >=media-sound/lash-0.5 ) )"

S="${WORKDIR}/${P/7a/7}"

# Alsa is required for lash support in this package.
pkg_setup() {
	if use lash && ! use alsa; then
		ewarn "ALSA support is required for lash support to be enabled."
		ewarn "Continuing with lash support disabled."
	fi

	if use alsa && ! built_with_use --missing true media-libs/alsa-lib midi; then
		eerror ""
		eerror "To be able to build Fluidsynth with ALSA support you need"
		eerror "to have built media-libs/alsa-lib with midi USE flag."
		die "Missing midi USE flag on media-libs/alsa-lib"
	fi
}

src_compile() {
	local myconf

	if use alsa; then
		myconf="${myconf} $(use_enable lash)"
	else
		myconf="--disable-lash"
	fi

	elibtoolize
	# ladcca support is deprecated in place of lash
	econf \
		--disable-ladcca \
		--disable-dependency-tracking \
		$(use_enable ladspa) \
		$(use_enable jack jack-support) \
		$(use_enable oss oss-support) \
		$(use_enable alsa alsa-support) \
		$(use_enable lash) \
		$(use_enable debug) \
		${myconf} || die "./configure failed"

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README THANKS TODO
}
