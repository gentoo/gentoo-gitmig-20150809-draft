# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tunepimp/tunepimp-0.3.0.ebuild,v 1.1 2004/08/10 20:56:51 caleb Exp $

IUSE="flac oggvorbis readline"

DESCRIPTION="Client library to access metadata of mp3/vorbis/CD media"
HOMEPAGE="http://www.musicbrainz.org/"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/lib${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~x86"

RDEPEND="dev-libs/expat"

DEPEND="${RDEPEND}
	flac? ( media-libs/flac )
	oggvorbis? ( media-libs/libvorbis )
	readline? ( sys-libs/readline )
	media-libs/libmad media-libs/libid3tag
	media-libs/musicbrainz
	dev-util/pkgconfig"

S=${WORKDIR}/lib${P}

src_compile() {
	econf || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO
}

