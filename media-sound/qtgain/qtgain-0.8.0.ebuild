# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qtgain/qtgain-0.8.0.ebuild,v 1.1 2009/12/23 21:57:04 ssuominen Exp $

EAPI=2
inherit eutils qt4

DESCRIPTION="A simple frontend to mp3gain, vorbisgain and metaflac"
HOMEPAGE="http://www.qt-apps.org/content/show.php/QtGain?content=56842"
SRC_URI="http://www.qt-apps.org/CONTENT/content-files/56842-QtGain.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="flac mp3 vorbis"

RDEPEND="flac? ( media-libs/flac )
	mp3? ( media-sound/mp3gain )
	vorbis? ( media-sound/vorbisgain )"

S=${WORKDIR}/QtGain

src_configure() {
	eqmake4 QtGain.pro
}

src_install() {
	dobin bin/QtGain || die
	newicon Icons/lsongs.png qtgain.png
	make_desktop_entry QtGain QtGain
}
