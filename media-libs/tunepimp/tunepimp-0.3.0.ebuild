# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/tunepimp/tunepimp-0.3.0.ebuild,v 1.17 2004/11/17 11:17:26 kloeri Exp $

inherit eutils

IUSE="flac mad oggvorbis readline"

DESCRIPTION="Client library to create MusicBrainz enabled tagging applications"
HOMEPAGE="http://www.musicbrainz.org/products/tunepimp"
SRC_URI="http://ftp.musicbrainz.org/pub/musicbrainz/lib${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 sparc ppc ~ppc64 hppa alpha"

RDEPEND="dev-libs/expat"

DEPEND="${RDEPEND}
	flac? ( media-libs/flac )
	oggvorbis? ( media-libs/libvorbis )
	readline? ( sys-libs/readline )
	mad? ( media-libs/libmad )
	>=media-libs/musicbrainz-2.1.0
	dev-util/pkgconfig
	!media-sound/trm"

S=${WORKDIR}/lib${P}

src_compile() {
	epatch ${FILESDIR}/thread.patch
	econf || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL README TODO
}

