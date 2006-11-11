# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3c/mp3c-0.29-r1.ebuild,v 1.2 2006/11/11 00:04:19 ticho Exp $

inherit eutils

IUSE="vorbis"

DESCRIPTION="console based mp3 ripper, with cddb support"
HOMEPAGE="http://wspse.de/WSPse/Linux-MP3c.php3"
SRC_URI="ftp://excelsior.kullen.rwth-aachen.de/pub/linux/wspse/${P}.tar.gz"

DEPEND="media-sound/lame
	>=media-sound/mp3info-0.8.4-r1
	virtual/cdrtools
	vorbis? ( media-libs/libvorbis )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc x86"

LANGS="de es it pl pt"

for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-buffer.patch"
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS *README BUGS CDDB_HOWTO ChangeLog FAQ NEWS OTHERS TODO
}
