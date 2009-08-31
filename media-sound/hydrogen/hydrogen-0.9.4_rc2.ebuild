# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/hydrogen/hydrogen-0.9.4_rc2.ebuild,v 1.3 2009/08/31 10:56:23 ssuominen Exp $

EAPI=2
MY_P=${P/_/-}
inherit eutils multilib

DESCRIPTION="Advanced Drum Machine"
HOMEPAGE="http://www.hydrogen-music.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2 ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa oss jack lash ladspa flac"

RDEPEND="jack? ( media-sound/jack-audio-connection-kit )
	alsa? ( media-libs/alsa-lib )
	lash? ( media-sound/lash )
	flac? ( media-libs/flac[cxx] )
	ladspa? ( media-libs/liblrdf )
	app-arch/libarchive
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-opengl:4
	x11-libs/qt-script:4
	x11-libs/qt-qt3support:4"
DEPEND="${RDEPEND}
	dev-util/scons"

S=${WORKDIR}/${MY_P}

src_compile() {
	export QTDIR="/usr/$(get_libdir)"
	local myconf="prefix=/usr libarchive=1"
	use oss || myconf="${myconf} oss=0"
	use alsa || myconf="${myconf} alsa=0"
	use jack || myconf="${myconf} jack=0"
	use lash || myconf="${myconf} lash=0"
	use ladspa || myconf="${myconf} lrdf=0"
	use flac || myconf="${myconf} flac=0"
	scons ${myconf} || die "scons failed"
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
