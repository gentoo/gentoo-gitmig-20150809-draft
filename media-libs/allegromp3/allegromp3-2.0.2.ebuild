# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/allegromp3/allegromp3-2.0.2.ebuild,v 1.1 2002/12/12 13:25:16 lordvan Exp $

DESCRIPTION="AllegroMP3 is an Allegro wrapper for the mpglib MP3 decoder part of mpg123."
HOMEPAGE="http://nekros.freeshell.org/delirium/almp3.php"
SRC_URI="http://raythe.sytes.net/TheDeath/almp3.zip"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=media-libs/allegro-4.0.0
        >=media-sound/mpg123-0.59r
        >=app-arch/unzip-5.50"
RDEPEND="${DEPEND}"
S="${WORKDIR}"

src_compile() {
    cd ${S}
    sh fixunix.sh
    mv Makefile Makefile_orig
    sed s/'^TARGET=DJGPP_STATIC'/'#TARGET=DJGPP_STATIC'/ Makefile_orig| sed s/'#TARGET=LINUX_STATIC'/'TARGET=LINUX_STATIC'/ > Makefile

    emake || die
}

src_install() {
    cd ${S} # needed? -- just to be sure ;)
    dodir /usr/include
    dodir /usr/lib
  
    insinto /usr/lib
    doins lib/linux/libalmp3.a
    
    insinto /usr/include
    doins include/*.h

    dodoc docs/*.txt *.txt

    insinto /usr/share/doc/${P}/examples
    doins examples/Makefile examples/example.c

}
