# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mixxx/mixxx-1.7.1.ebuild,v 1.1 2009/12/18 06:27:26 darkside Exp $

EAPI=2
MY_P=${P/_/-}
inherit eutils multilib

DESCRIPTION="a QT based Digital DJ tool"
HOMEPAGE="http://mixxx.sourceforge.net"
SRC_URI="http://downloads.mixxx.org/${MY_P}/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug +djconsole hifieq ipod shout +vinylcontrol ladspa"

RDEPEND="media-libs/mesa
	media-libs/libmad
	media-libs/libid3tag
	media-libs/libvorbis
	media-libs/libsndfile
	>=media-libs/portaudio-19_pre
	djconsole? ( media-libs/libdjconsole )
	shout? ( media-libs/libshout )
	ladspa? ( media-libs/ladspa-sdk )
	virtual/glu
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	x11-libs/qt-opengl:4"
DEPEND="${RDEPEND}
	dev-util/scons
	dev-util/pkgconfig"

S=${WORKDIR}/${P/_/\~}

src_prepare() {
	sed -i -e 's:-O3::g' lib/cmetrics/SConscript || die "sed failed"
}

src_configure() {
	myconf="optimize=0 ladspa=0 ffmpeg=0 script=0 prefix=/usr
		qtdir=/usr/$(get_libdir)/qt4"

	use djconsole && myconf+=" djconsole=1 djconsole_legacy=1" || myconf+=" djconsole=0 djconsole_legacy=0"
	use hifieq && myconf+=" hifieq=1" || myconf+=" hifieq=0"
	use debug && myconf+=" cmetrics=1" || myconf+=" cmetrics=0"
	use ipod && myconf+=" ipod=1" || myconf+=" ipod=0"
	use shout && myconf+=" shoutcast=1" || myconf+=" shoutcast=0"
	use ladspa && myconf+=" ladspa=1" || myconf+=" ladspa=0"
	use vinylcontrol && myconf+=" vinylcontrol=1" || myconf+=" vinylcontrol=0"
	#use ffmpg && myconf+=" ffmpg=1" || myconf+=" ffmpg=0"

	$(type -P scons) ${myconf} -c . || die "scons config failed"
}

src_compile() {
	$(type -P scons) ${myconf} || die "scons compile failed"
}

src_install() {
	dobin mixxx || die "dobin failed."

	insinto /usr/share/mixxx
	doins -r res/{skins,midi,keyboard}
	use ladspa && doins res/ladspa_presets

	doicon res/images/mixxx-icon.png
	domenu src/mixxx.desktop

	dodoc README*

	insinto /usr/share/doc/${PF}
	doins Mixxx-Manual.pdf
}
