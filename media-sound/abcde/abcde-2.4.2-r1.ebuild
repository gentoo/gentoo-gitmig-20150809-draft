# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/abcde/abcde-2.4.2-r1.ebuild,v 1.2 2011/12/16 18:14:49 ago Exp $

EAPI=2
inherit eutils

DESCRIPTION="A command line CD encoder"
HOMEPAGE="http://code.google.com/p/abcde/"
SRC_URI="http://abcde.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="aac cdparanoia flac id3 lame normalize replaygain speex vorbis"

RDEPEND="media-sound/cd-discid
	net-misc/wget
	virtual/eject
	aac? ( media-libs/faac
		media-video/atomicparsley )
	cdparanoia? ( media-sound/cdparanoia )
	flac? ( media-libs/flac )
	id3? (
		>=media-sound/id3-0.12
		media-sound/id3v2
	)
	lame? ( media-sound/lame )
	normalize? ( >=media-sound/normalize-0.7.4 )
	replaygain? (
		vorbis? ( media-sound/vorbisgain )
		lame? ( media-sound/mp3gain )
		)
	speex? ( media-libs/speex )
	vorbis? ( media-sound/vorbis-tools )"

src_prepare() {
	epatch "${FILESDIR}"/m4a-tagging.patch
	sed -i \
		-e 's:/etc/abcde.conf:/etc/abcde/abcde.conf:g' \
		abcde || die
}

src_install() {
	emake DESTDIR="${D}" etcdir="${D}etc/abcde" install || die
	dodoc changelog FAQ README TODO USEPIPES || die
	docinto examples
	dodoc examples/* || die
}
