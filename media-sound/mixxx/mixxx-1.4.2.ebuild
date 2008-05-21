# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mixxx/mixxx-1.4.2.ebuild,v 1.8 2008/05/21 00:03:36 drac Exp $

inherit eutils qt3

DESCRIPTION="Digital DJ tool using QT 3.x"
HOMEPAGE="http://mixxx.sourceforge.net"
SRC_URI="mirror://sourceforge/mixxx/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="sparc ~ppc x86"
IUSE="alsa jack"

RDEPEND="$(qt_min_version 3.1)
	media-sound/madplay
	media-libs/libogg
	media-libs/libvorbis
	media-libs/audiofile
	media-libs/libsndfile
	media-libs/libsamplerate
	media-libs/portaudio
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/pkgconfig
	sys-apps/sed"

S=${WORKDIR}/${P}/src

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.3.2-gentoo.patch
}

src_compile() {
	./configure `use_enable alsa` `use_enable jack` || die "configure failed."

	sed -i -e "s/CFLAGS *= -pipe -w -O2/CFLAGS   = ${CFLAGS} -w/" \
	       -e "s/CXXFLAGS *= -pipe -w -O2/CXXFLAGS   = ${CXXFLAGS} -w/" Makefile

	addpredict ${QTDIR}/etc/settings
	emake || die "emake failed."
}

src_install() {
	insinto /usr/share/mixxx
	doins -r skins midi keyboard || die "doins failed."

	dobin mixxx || die "dobin failed."

	dodoc ../{README,README.ALSA,Mixxx-Manual.pdf}
}
