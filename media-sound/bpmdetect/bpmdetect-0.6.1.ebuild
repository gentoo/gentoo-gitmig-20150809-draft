# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bpmdetect/bpmdetect-0.6.1.ebuild,v 1.1 2008/12/21 17:00:36 ssuominen Exp $

EAPI=1

inherit eutils multilib

DESCRIPTION="Automatic BPM detection utility"
HOMEPAGE="http://sourceforge.net/projects/bpmdetect"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="media-libs/taglib
	media-libs/id3lib
	media-libs/fmod:1
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	dev-util/scons
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	sed -i -e "s:-O2:${CXXFLAGS}:" "${S}"/src/SConscript || die "sed failed."
}

src_compile() {
	export QTDIR="/usr/$(get_libdir)"
	scons prefix=/usr || die "scons failed."
}

src_install() {
	dobin build/${PN} || die "dobin failed."
	doicon src/${PN}-icon.png
	domenu src/${PN}.desktop
	dodoc authors readme todo
}
