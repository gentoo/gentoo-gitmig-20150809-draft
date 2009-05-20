# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kid3/kid3-1.2.ebuild,v 1.1 2009/05/20 20:49:33 ssuominen Exp $

EAPI=2
inherit cmake-utils

DESCRIPTION="A simple ID3 tag editor for QT/KDE."
HOMEPAGE="http://kid3.sourceforge.net/"
SRC_URI="mirror://sourceforge/kid3/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND=">=media-libs/id3lib-3.8.3
	media-libs/taglib
	media-libs/libmp4v2
	media-libs/libvorbis
	media-libs/flac[cxx]
	>=kde-base/kdelibs-4
	media-libs/musicbrainz:3
	media-libs/tunepimp"
DEPEND="${RDEPEND}"

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS ChangeLog NEWS README
}
