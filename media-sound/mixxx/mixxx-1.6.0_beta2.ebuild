# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mixxx/mixxx-1.6.0_beta2.ebuild,v 1.2 2008/05/21 00:03:36 drac Exp $

EAPI=1

inherit eutils toolchain-funcs

MY_P=${P/_/-}

DESCRIPTION="a QT based Digital DJ tool"
HOMEPAGE="http://mixxx.sourceforge.net"
SRC_URI="mirror://sourceforge/mixxx/${MY_P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug djconsole hifieq ladspa recording shout +vinylcontrol"

# TODO. It bundles libs, like samplerate, why?
RDEPEND="media-libs/mesa
	media-libs/libmad
	media-libs/libid3tag
	media-libs/libvorbis
	media-libs/libsndfile
	>=media-libs/portaudio-19_pre
	djconsole? ( media-libs/libdjconsole )
	shout? ( media-libs/libshout )
	ladspa? ( media-libs/ladspa-sdk )
	media-libs/mesa
	virtual/glu
	|| ( ( x11-libs/qt-core
		x11-libs/qt-gui
		x11-libs/qt-opengl )
		>=x11-libs/qt-4.3:4 )"
DEPEND="${RDEPEND}
	dev-util/scons
	dev-util/pkgconfig"

S=${WORKDIR}/${P/_}

pkg_setup() {
	if ! has_version x11-libs/qt-opengl && ! built_with_use -a =x11-libs/qt-4* opengl qt3support; then
		die "Re-emerge x11-libs/qt with USE flag opengl and qt3support."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# http://dev.gentoo.org/~vapier/scons-blows.txt
	epatch "${FILESDIR}"/${P}-toolchain_and_write.patch
	# and more..
	sed -i -e "s:-O3::g" lib/cmetrics/SConscript || die "sed failed."
}

src_compile() {
	local myconf="optimize=0 ffmpeg=0 script=0 prefix=/usr"

	use djconsole && myconf+=" djconsole=1" || myconf+=" djconsole=0"
	use hifieq && myconf+=" hifieq=1" || myconf+=" hifieq=0"
	use debug && myconf+=" cmetrics=1" || myconf+=" cmetrics=0"
	use shout && myconf+=" shoutcast=1" || myconf+=" shoutcast=0"
	use ladspa && myconf+=" ladspa=1" || myconf+=" ladspa=0"
	use recording && myconf+=" experimentalrecord=1" || myconf+=" experimentalrecord=0"
	use vinylcontrol && myconf+=" vinylcontrol=1" || myconf+=" vinylcontrol=0"

	tc-export CXX
	$(type -P scons) ${myconf} -c . || die "scons -c . failed."
	$(type -P scons) ${myconf} || die "scons failed."
}

src_install() {
	dobin mixxx || die "dobin failed."

	insinto /usr/share/mixxx
	doins -r src/{skins,midi,keyboard} || die "doins failed."

	doicon src/mixxx-icon.png
	domenu src/mixxx.desktop

	dodoc HERCULES.txt README*

	insinto /usr/share/doc/${PF}
	doins Mixxx-Manual.pdf
}
