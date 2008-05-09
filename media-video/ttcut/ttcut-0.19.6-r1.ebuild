# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ttcut/ttcut-0.19.6-r1.ebuild,v 1.3 2008/05/09 09:56:17 yngwin Exp $

EAPI="1"
inherit eutils qt4

DESCRIPTION="Tool for removing advertisements from recorded MPEG files"
HOMEPAGE="http://ttcut.tritime.org/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( >=x11-libs/qt-4.3.0:4 ( x11-libs/qt-gui:4 x11-libs/qt-opengl:4 ) )
	>=media-libs/libmpeg2-0.4.0
	virtual/opengl"

RDEPEND="${DEPEND}
	media-video/mplayer
	media-video/transcode"

S=${WORKDIR}/${PN}

pkg_setup() {
	if ! built_with_use media-video/transcode mjpeg ; then
		eerror "In order to have encoding mode working with ttcut"
		eerror "you need to recompile transcode with mjpeg USE flag enabled."
		die "Recompile transcode with mjpeg USE flag enabled"
	fi
}

src_compile() {
	eqmake4 ttcut.pro -o Makefile.ttcut
	emake -f Makefile.ttcut || die "emake failed"
}

src_install() {
	dobin ttcut || die "Couldn't install ttcut"
	make_desktop_entry ttcut TTCut "" "AudioVideo;Video;AudioVideoEditing" || \
		die "Couldn't make ttcut desktop entry"

	dodoc AUTHORS BUGS CHANGELOG \
		README.DE README.EN TODO || die "Couldn't install documentation"
}
