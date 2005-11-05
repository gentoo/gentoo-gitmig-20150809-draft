# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kid3/kid3-0.6.ebuild,v 1.1 2005/11/05 20:07:00 greg_g Exp $

inherit kde-functions

DESCRIPTION="A simple ID3 tag editor for QT/KDE."
HOMEPAGE="http://kid3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kid3/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="flac kde musicbrainz vorbis"

DEPEND="=x11-libs/qt-3*
	>=media-libs/id3lib-3.8.3
	kde? ( kde-base/kdelibs )
	vorbis? ( media-libs/libvorbis )
	flac? ( media-libs/flac )
	musicbrainz? ( media-libs/tunepimp )"

set-kdedir 3

src_compile() {
	local myconf="$(use_with kde)
	              $(use_with vorbis)
	              $(use_with flac)
	              $(use_with musicbrainz)"

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
