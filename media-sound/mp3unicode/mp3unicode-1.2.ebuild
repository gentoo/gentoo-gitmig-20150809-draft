# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3unicode/mp3unicode-1.2.ebuild,v 1.1 2007/09/28 20:40:55 alonbl Exp $

DESCRIPTION="MP3Unicode is a command line utility to convert ID3 tags in mp3 files between different encodings"
HOMEPAGE="http://mp3unicode.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/taglib-1.4"
RDEPEND="${DEPEND}"

src_install() {
	emake install DESTDIR="${D}" || die
	prepalldocs
}
