# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvbcut/dvbcut-0.6.0.ebuild,v 1.1 2009/06/19 20:06:13 aballier Exp $

EAPI=2

inherit eutils qt3

DESCRIPTION="frame-accurate editing of MPEG-2 video with MPEG and AC3 audio"
HOMEPAGE="http://dvbcut.sourceforge.net"
#SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
SRC_URI="http://www.mr511.de/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt:3
	media-libs/a52dec
	media-libs/libao
	media-libs/libmad
	media-video/ffmpeg"

DEPEND="${RDEPEND}"

src_configure() {
	econf --with-ffmpeg=/usr
}

src_install() {
	# disable parallel build
	# already created MANDIR causes the build to fail
	emake -j1 DESTDIR="${D}" install \
		|| die "Emake install failed"
	make_desktop_entry dvbcut DVBcut
	dodoc ChangeLog CREDITS README README.ffmpeg README.icons
}
