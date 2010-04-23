# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/denemo/denemo-0.8.16.ebuild,v 1.1 2010/04/23 14:28:43 ssuominen Exp $

EAPI=2

DESCRIPTION="A music notation editor"
HOMEPAGE="http://www.denemo.org/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2 OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="jack nls"

COMMON_DEPEND="x11-libs/gtk+:2
	>=dev-scheme/guile-1.8
	>=media-libs/aubio-0.3.2
	>=media-libs/portaudio-19_pre
	>=dev-libs/libxml2-2.3.10
	>=sci-libs/fftw-3.1.2
	>=x11-libs/gtksourceview-2
	>=media-sound/fluidsynth-1.0.8
	>=media-libs/libsamplerate-0.1.2
	media-libs/alsa-lib
	jack? ( >=media-sound/jack-audio-connection-kit-0.102 )"
RDEPEND="${COMMON_DEPEND}
	media-sound/lilypond
	gnome-base/librsvg"
DEPEND="${COMMON_DEPEND}
	|| ( dev-util/yacc sys-devel/bison )
	sys-devel/flex
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable jack)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog doc/{DESIGN*,GOALS,TODO} NEWS README* || die
}
