# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3_check/mp3_check-1.98.ebuild,v 1.8 2004/03/01 05:37:15 eradicator Exp $

S=${WORKDIR}/${P}
DESCRIPTION="MP3 consistancy checker"
HOMEPAGE="http://sourceforge.net/projects/mp3check/"
SRC_URI="mirror://sourceforge/mp3check/${P}.tar.gz"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc"

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
	dodoc WISHLIST TODO THANKYOU README *NOTES FOR_TESTING GOALS MILESTONE*
}
