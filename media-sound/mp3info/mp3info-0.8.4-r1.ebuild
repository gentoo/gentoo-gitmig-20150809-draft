# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3info/mp3info-0.8.4-r1.ebuild,v 1.11 2003/09/07 00:06:06 msterret Exp $

IUSE="gtk"

S=${WORKDIR}/${P}
DESCRIPTION="An MP3 technical info viewer and ID3 1.x tag editor"
SRC_URI="http://ibiblio.org/pub/linux/apps/sound/mp3-utils/${PN}/${P}.tgz"
HOMEPAGE="http://ibiblio.org/mp3info/"

DEPEND="gtk? ( =x11-libs/gtk+-1.2* )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

src_unpack() {

	unpack ${A}

	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {

	emake mp3info || die
	if [ `use gtk` ]; then
		emake gmp3info || die "gtk mp3info failed"
	fi
}

src_install() {

	dobin mp3info
	use gtk && dobin gmp3info

	dodoc ChangeLog INSTALL LICENSE README
	doman mp3info.1
}
