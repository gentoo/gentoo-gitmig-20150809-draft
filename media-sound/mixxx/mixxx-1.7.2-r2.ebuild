# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mixxx/mixxx-1.7.2-r2.ebuild,v 1.1 2010/08/06 23:10:58 hwoarang Exp $

EAPI=2
inherit eutils multilib

DESCRIPTION="a QT based Digital DJ tool"
HOMEPAGE="http://mixxx.sourceforge.net"
SRC_URI="http://downloads.mixxx.org/${P}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug +hifieq ipod ladspa pulseaudio shout tonal +vinylcontrol"

RDEPEND="media-libs/libmad
	media-libs/libid3tag
	media-libs/libvorbis
	media-libs/libsndfile
	>=media-libs/portaudio-19_pre
	virtual/opengl
	virtual/glu
	x11-libs/qt-gui:4
	x11-libs/qt-svg:4
	x11-libs/qt-opengl:4
	>=media-libs/libsoundtouch-1.5.0
	ladspa? ( media-libs/ladspa-sdk )
	pulseaudio? ( media-sound/pulseaudio )
	shout? ( media-libs/libshout )"
DEPEND="${RDEPEND}
	dev-util/scons
	dev-util/pkgconfig"

pkg_setup() {
	mysconsargs="prefix=/usr
		qtdir=/usr/$(get_libdir)/qt4
		djconsole=0
		djconsole_legacy=0
		optimize=0
		install_root=${D}/usr"

	use hifieq && mysconsargs+=" hifieq=1" || mysconsargs+=" hifieq=0"
	use ipod && mysconsargs+=" ipod=1" || mysconsargs+=" ipod=0"
	use ladspa && mysconsargs+=" ladspa=1" || mysconsargs+=" ladspa=0"
	use vinylcontrol && mysconsargs+=" vinylcontrol=1" || mysconsargs+=" vinylcontrol=0"
	use shout && mysconsargs+=" shoutcast=1" || mysconsargs+=" shoutcast=0"
	use debug && mysconsargs+=" cmetrics=1" || mysconsargs+=" cmetrics=0"
	use tonal && mysconsargs+=" tonal=1" || mysconsargs+=" tonal=0"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-external_libsoundtouch.patch
	sed -i \
		-e 's:-O3::g' \
		lib/cmetrics/SConscript || die

	use pulseaudio || sed -i -e 's:pasuspender ::' src/mixxx.desktop
	# Respect {C,CXX,LD}FLAGS. Bug #317519
	epatch "${FILESDIR}"/${P}-flags.patch
}

src_compile() {
	scons ${mysconsargs} || die
}

src_install() {
	scons ${mysconsargs} install || die

	dodoc README*

	insinto /usr/share/doc/${PF}/pdf
	doins Mixxx-Manual.pdf
}
