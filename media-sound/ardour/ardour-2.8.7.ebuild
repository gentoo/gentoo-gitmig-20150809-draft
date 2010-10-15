# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ardour/ardour-2.8.7.ebuild,v 1.3 2010/10/15 18:50:05 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Digital Audio Workstation"
HOMEPAGE="http://ardour.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="altivec curl debug nls lv2 sse"

# FIXME: Bundled libraries in libs/
RDEPEND="media-libs/aubio
	media-libs/liblo
	lv2? ( >=media-libs/slv2-0.6.1 )
	sci-libs/fftw:3.0
	media-libs/freetype:2
	>=dev-libs/glib-2.10.1:2
	>=x11-libs/gtk+-2.8.1:2
	>=dev-libs/libxml2-2.6
	>=media-libs/libsndfile-1.0.18
	>=media-libs/libsamplerate-0.1
	media-libs/libsoundtouch
	media-libs/flac
	>=media-libs/raptor-1.4.2
	<media-libs/raptor-1.9.0
	>=media-libs/liblrdf-0.4
	>=media-sound/jack-audio-connection-kit-0.109
	>=gnome-base/libgnomecanvas-2
	media-libs/vamp-plugin-sdk
	dev-libs/libxslt
	dev-libs/libsigc++:2
	>=dev-cpp/gtkmm-2.16
	>=dev-cpp/libgnomecanvasmm-2.26
	media-libs/alsa-lib
	curl? ( net-misc/curl )"
DEPEND="${RDEPEND}
	dev-libs/boost
	dev-util/pkgconfig
	>=dev-util/scons-1
	nls? ( sys-devel/gettext )"

ardour_use_enable() {
	use ${2} && echo "${1}=1" || echo "${1}=0"
}

src_compile() {
	local FPU_OPTIMIZATION=$((use altivec || use sse) && echo 1 || echo 0)
	tc-export CC CXX
	mkdir -p "${D}"

	scons \
		CFLAGS="${CFLAGS}" \
		$(ardour_use_enable DEBUG debug) \
		DESTDIR="${D}" \
		$(ardour_use_enable FREESOUND curl) \
		FPU_OPTIMIZATION="${FPU_OPTIMIZATION}" \
		$(ardour_use_enable NLS nls) \
		PREFIX=/usr \
		SYSLIBS=1 \
		$(ardour_use_enable LV2 lv2) \
		|| die
}

src_install() {
	scons install || die
	newicon icons/icon/ardour_icon_mac.png ${PN}.png
	make_desktop_entry ardour2 Ardour
}
