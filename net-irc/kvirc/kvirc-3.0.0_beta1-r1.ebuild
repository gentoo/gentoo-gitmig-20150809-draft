# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/kvirc/kvirc-3.0.0_beta1-r1.ebuild,v 1.1 2003/05/22 07:52:33 pauldv Exp $

IUSE="kde esd ipv6"
inherit kde-base

MYP=${P//_/-}
MYPV=${PV//_/-}
S=${WORKDIR}/${MYP}
DESCRIPTION="An advanced IRC Client"
SRC_URI="ftp://ftp.kvirc.net/kvirc/${MYPV}/source/${MYP}.tar.gz"
HOMEPAGE="http://www.kvirc.net"

SLOT="3"
LICENSE="kvirc"
KEYWORDS="x86"

use kde && need-kde 3 || need-qt 3

newdepend "esd? ( media-sound/esound )"
#	   ssl? ( dev-libs/openssl )"
use kde || newdepend "arts? ( kde-base/arts )"

[ -n "$DEBUG" ]		&& myconf="$myconf --with-debug-symbols"

#The assembly seems to be less than stable
#[ "$ARCH" == "x86" ]	&& myconf="$myconf --with-ix86-asm"

use ipv6		&& myconf="$myconf --with-ipv6-support" \
			|| myconf="$myconf --without-ipv6-support"
# arts support without kde support isn't liked by the configure script
# possibly it could be made to work but i didn't want to spend time on it
use kde			&& myconf="$myconf --with-kde-support --with-arts-support" \
			|| myconf="$myconf --without-kde-support --without-arts-support" 
use esd			&& myconf="$myconf --with-esd-support" \
			|| myconf="$myconf --without-esd-support" 
# no use flag as yet, and a hard dep is rather pointless
#use audiofile		&& myconf="$myconf --with-arts-support" \
#			|| myconf="$myconf --without-arts-support" 
# doesn't compile
#use ssl			&& myconf="$myconf --with-ssl-support" \
#			|| myconf="$myconf --without-ssl-support" 

# use aa even when kde support is disabled
myconf="$myconf --with-aa-fonts"

src_compile() {

    use kde && kde_src_compile myconf

    # always install into /usr regardless of kde support
    # kvirc doesn't have a kde-like installed file structure anyway
    myconf="$myconf --prefix=/usr -v"
    
    # make sure we disable kde support as the configure script can auto-enable
    # it when it isn't wanted
    use kde || export KDEDIR=""
    
    kde_src_compile configure make    

}

src_install () {
    
    make install DESTDIR=${D} || die
    make docs DESTDIR=${D} || die

    dodoc ChangeLog INSTALL README TODO
    
}


