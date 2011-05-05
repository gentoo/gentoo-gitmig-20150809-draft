# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/denemo/denemo-0.9.0.ebuild,v 1.1 2011/05/05 17:54:55 angelos Exp $

EAPI=4
inherit fdo-mime

DESCRIPTION="A music notation editor"
HOMEPAGE="http://www.denemo.org/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3 OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="jack +fluidsynth nls +portaudio"

COMMON_DEPEND="
	dev-libs/libxml2:2
	>=dev-scheme/guile-1.8
	gnome-base/librsvg:2
	media-libs/alsa-lib
	x11-libs/gtk+:2
	x11-libs/gtksourceview:2.0
	jack? ( >=media-sound/jack-audio-connection-kit-0.102 )
	fluidsynth? ( media-sound/fluidsynth )
	portaudio? ( media-libs/portaudio
		media-libs/aubio
		sci-libs/fftw:3.0
		media-libs/libsamplerate )"
RDEPEND="${COMMON_DEPEND}
	media-sound/lilypond"
DEPEND="${COMMON_DEPEND}
	|| ( dev-util/yacc sys-devel/bison )
	sys-devel/flex
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS ChangeLog doc/{DESIGN{,.lilypond},GOALS,TODO} NEWS )

src_configure() {
	econf \
		--disable-static \
		$(use_enable fluidsynth) \
		$(use_enable jack) \
		$(use_enable nls) \
		$(use_enable portaudio)
}

pkg_postinst() { fdo-mime_desktop_database_update; }
pkg_postrm() { fdo-mime_desktop_database_update; }
