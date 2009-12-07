# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rosegarden/rosegarden-1.5.1.ebuild,v 1.7 2009/12/07 05:46:17 ssuominen Exp $

inherit eutils kde-functions

MY_PV="${PV/_rc*/}"
#MY_PV="${MY_PV/4./}"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="MIDI and audio sequencer and notation editor."
HOMEPAGE="http://www.rosegardenmusic.com/"
SRC_URI="mirror://sourceforge/rosegarden/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc"
IUSE="alsa jack dssi lirc debug"

RDEPEND="
	alsa? ( >=media-libs/alsa-lib-1.0
		jack? ( >=media-sound/jack-audio-connection-kit-0.77 )
	)
	>=media-libs/ladspa-sdk-1.0
	>=media-libs/ladspa-cmt-1.14
	dssi? ( >=media-libs/dssi-0.4 )
	lirc? ( >=app-misc/lirc-0.7 )
	>=media-libs/liblrdf-0.3
	>=sci-libs/fftw-3.0.0
	>=media-libs/liblo-0.7"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15
	>=dev-util/cmake-2.4.2"

need-kde 3.1

LANGS="ca cs cy de en_GB en es et fr it ja nl ru sv zh_CN"

for lang in $LANGS; do
	IUSE="${IUSE} linguas_$lang"
done

pkg_setup() {
	if ! use alsa && use jack; then
		ewarn "If you want JACK support you also need to enable"
		ewarn "ALSA support, or the whole sound support will be"
		ewarn "disabled."
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-asneeded.patch"
}

src_compile() {
	local myconf=""
	cmake . -DCMAKE_INSTALL_PREFIX=/usr \
		-DWANT_DEBUG="$(! use debug; echo "$?")" \
		-DWANT_FULLDBG="$(! use debug; echo "$?")" \
		-DWANT_SOUND="$(! use alsa; echo "$?")" \
		-DWANT_JACK="$(! use jack; echo "$?")" \
		-DWANT_DSSI="$(! use dssi; echo "$?")" \
		-DWANT_LIRC="$(! use lirc; echo "$?")" \
		|| die "cmake failed"

	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" languages="$(echo $(echo "${LINGUAS} ${LANGS}" | fmt -w 1 | sort | uniq -d))" || die "emake install failed"
	dodoc ChangeLog AUTHORS README TRANSLATORS
}
