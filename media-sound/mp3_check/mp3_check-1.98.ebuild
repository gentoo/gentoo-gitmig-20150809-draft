# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3_check/mp3_check-1.98.ebuild,v 1.1 2002/06/28 16:27:52 lostlogic Exp $

S=${WORKDIR}/${P}
DESCRIPTION="MP3 consistancy checker"
HOMEPAGE="http://sourceforge.net/projects/mp3check/"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/mp3check/${P}.tar.gz"
DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"
LICENSE="GPL"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed -e "s:/usr/local:/usr:;
		s:-Werror:${CFLAGS}:" Makefile.orig > Makefile
}

src_compile() {
	emake || die
}
src_install () {
	dobin mp3_check
	dodoc WISHLIST TODO THANKYOU README NOTES MY_NOTES FOR_TESTING GOALS MILESTONE MILESTONE.INTRO
}
