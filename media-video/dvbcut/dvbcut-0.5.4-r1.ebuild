# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvbcut/dvbcut-0.5.4-r1.ebuild,v 1.3 2008/05/10 15:11:07 zzam Exp $

inherit qt3 eutils

IUSE=""

MY_P="${P/-/_}"

DESCRIPTION="frame-accurate editing of MPEG-2 video with MPEG and AC3 audio"
HOMEPAGE="http://dvbcut.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="$(qt_min_version 3)
	media-libs/libao
	>=media-video/ffmpeg-0.4.9_p20070330"

DEPEND="${RDEPEND}
	dev-util/scons"

pkg_setup() {
	 if ! built_with_use media-video/ffmpeg a52; then
	 	eerror "This package requires media-video/ffmpeg compiled with A/52 (a.k.a. AC-3) support."
		eerror "Please reemerge media-video/ffmpeg with USE=\"a52\"."
		die "Please reemerge media-video/ffmpeg with USE=\"a52\"."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-0.5.3-ffmpeg-compat.patch"
	epatch "${FILESDIR}/${P}-gcc42.patch"
	epatch "${FILESDIR}/${P}-ffmpeg-compat2.patch"
	epatch "${FILESDIR}/${P}-ffmpeg-compat3.patch"
	epatch "${FILESDIR}/${P}-avformat-api-changes.patch"

	if has_version ">=media-video/ffmpeg-0.4.9_p20080326"; then
		epatch "${FILESDIR}/${P}-ffmpeg-0.4.9_p20080326.diff"
	fi
}

src_compile() {
	emake FFMPEG=/usr || die "build failed"
}

src_install() {
	emake FFMPEG=/usr DESTDIR="${D}" PREFIX="/usr" MANPATH="/usr/share/man" install \
		|| die "install failed"
	make_desktop_entry dvbcut DVBcut \
		|| die "Couldn't make dvbcut desktop entry"
	dodoc CREDITS ChangeLog README README.ffmpeg README.icons
}
