# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvbcut/dvbcut-0.5.3-r1.ebuild,v 1.1 2006/11/29 09:14:22 zzam Exp $

inherit qt3 eutils

IUSE=""

MY_P="${P/-/_}"

DESCRIPTION="frame-accurate editing of MPEG-2 video with MPEG and AC3 audio"
HOMEPAGE="http://dvbcut.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"

RDEPEND="$(qt_min_version 3)
	media-libs/libao
	media-video/ffmpeg"

DEPEND="${RDEPEND}
	dev-util/scons"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-ac3-buffer.patch"
}

src_compile() {
	emake FFMPEG=/usr || die "build failed"
}

src_install() {
	emake FFMPEG=/usr DESTDIR="${D}" PREFIX="/usr" MANPATH="/usr/share/man" install \
		|| die "install failed"
	dodoc CREDITS ChangeLog README README.ffmpeg README.icons
}
