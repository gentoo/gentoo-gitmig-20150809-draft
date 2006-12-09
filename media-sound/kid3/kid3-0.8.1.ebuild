# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kid3/kid3-0.8.1.ebuild,v 1.1 2006/12/09 12:37:48 masterdriverz Exp $

inherit kde

DESCRIPTION="A simple ID3 tag editor for QT/KDE."
HOMEPAGE="http://kid3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kid3/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="flac vorbis"

DEPEND=">=media-libs/id3lib-3.8.3
	vorbis? ( media-libs/libvorbis )
	flac? ( media-libs/flac )"
RDEPEND="${DEPEND}"

need-kde 3

# Support for the KDE libraries is optional,
# but the configure step that detects them
# cannot be avoided. So KDE support is forced on.

src_compile() {
	local myconf="--with-kde
				  $(use_with vorbis)
				  $(use_with flac)
				  --without-musicbrainz"

	kde_src_compile
}
