# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3c/mp3c-0.31.ebuild,v 1.1 2006/11/06 21:23:37 aballier Exp $

IUSE="mp3 vorbis"

DESCRIPTION="console based mp3 ripper, with cddb support"
HOMEPAGE="http://wspse.de/WSPse/Linux-MP3c.php3"
SRC_URI="ftp://ftp.wspse.de/pub/linux/wspse/${P}.tar.bz2"

RDEPEND="mp3? ( media-sound/lame
	>=media-sound/mp3info-0.8.4-r1 )
	virtual/cdrtools
	vorbis? ( media-sound/vorbis-tools )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

src_compile() {
	econf $(use_enable vorbis oggdefaults) || die "econf failed !"
	emake || die "emake failed!"
}

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS *README BUGS CDDB_HOWTO ChangeLog FAQ NEWS OTHERS TODO
}
