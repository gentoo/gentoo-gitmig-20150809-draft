# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/hydrogen/hydrogen-0.9.4.ebuild,v 1.8 2010/10/24 16:41:45 armin76 Exp $

EAPI=2
inherit eutils multilib

DESCRIPTION="Advanced drum machine"
HOMEPAGE="http://www.hydrogen-music.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 ZLIB"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="alsa flac jack ladspa lash oss"

RDEPEND="x11-libs/qt-gui:4
	app-arch/libarchive
	media-libs/libsndfile
	alsa? ( media-libs/alsa-lib )
	flac? ( media-libs/flac[cxx] )
	jack? ( media-sound/jack-audio-connection-kit )
	ladspa? ( media-libs/liblrdf )
	lash? ( media-sound/lash )"
DEPEND="${RDEPEND}
	dev-util/scons"

src_prepare() {
	sed -i \
		-e '/cppflags +=/d' \
			Sconstruct || die
}

src_compile() {
	export QTDIR="/usr/$(get_libdir)"

	local myconf="libarchive=1 portaudio=0 portmidi=0"

	use alsa || myconf="${myconf} alsa=0"
	use flac || myconf="${myconf} flac=0"
	use jack || myconf="${myconf} jack=0"
	use ladspa || myconf="${myconf} lrdf=0"
	use lash && myconf="${myconf} lash=1"
	use oss || myconf="${myconf} oss=0"

	scons \
		prefix=/usr \
		DESTDIR="${D}" \
		optflags="${CXXFLAGS}" \
		${myconf} || die
}

src_install() {
	dobin hydrogen || die
	insinto /usr/share/hydrogen
	doins -r data || die
	doicon data/img/gray/h2-icon.svg
	domenu hydrogen.desktop
	dosym /usr/share/hydrogen/data/doc /usr/share/doc/${PF}/html
	dodoc AUTHORS ChangeLog README.txt
}
