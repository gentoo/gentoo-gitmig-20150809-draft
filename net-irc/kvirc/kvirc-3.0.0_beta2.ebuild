# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/kvirc/kvirc-3.0.0_beta2.ebuild,v 1.3 2003/04/30 18:36:48 caleb Exp $
IUSE="kde esd ipv6 ssl"
inherit kde-base

MYP=${P//_/-}
MYPV=${PV//_/-}
S=${WORKDIR}/${MYP}
DESCRIPTION="An advanced IRC Client"
SRC_URI="ftp://ftp.kvirc.net/kvirc/${MYPV}/source/${MYP}.tar.gz"
HOMEPAGE="http://www.kvirc.net"

SLOT="3"
LICENSE="kvirc"
KEYWORDS="~x86"

use kde && need-kde 3 || need-qt 3

newdepend "esd? ( media-sound/esound )
	   ssl? ( dev-libs/openssl )
	   oss? ( media-libs/audiofile )"
use kde || newdepend "arts? ( kde-base/arts )"

[ -n "$DEBUG" ]		&& myconf="$myconf --with-debug-symbols"
[ "$ARCH" == "x86" ]	&& myconf="$myconf --with-ix86-asm"
#use ipv6		&& myconf="$myconf --with-ipv6-support" \
use ipv6		|| myconf="$myconf --without-ipv6-support"
# arts support without kde support isn't liked by the configure script
# possibly it could be made to work but i didn't want to spend time on it
# also, explicitly passing --with-kde-support seems to break configure's logic, so just
# let it autodetect in that case
#use kde		&& myconf="$myconf --with-kde-support --with-arts-support" \
use kde			|| myconf="$myconf --without-kde-support --without-arts-support" 
#use esd		&& myconf="$myconf --with-esd-support" \
use esd			|| myconf="$myconf --without-esd-support" 
use oss			&& myconf="$myconf --with-af--support" \
			|| myconf="$myconf --without-af-support" 
#use ssl		&& myconf="$myconf --with-ssl-support" \
use ssl			|| myconf="$myconf --without-ssl-support" 

# use aa even when kde support is disabled; disable local 8bit character set conversion, doesn't compile
myconf="$myconf --with-aa-fonts"

src_compile() {

    use kde && kde_src_compile myconf

    # always install into /usr regardless of kde support
    # kvirc doesn't have a kde-like installed file structure anyway
    myconf="$myconf --prefix=/usr -v"
    
    # make sure we disable kde support as the configure script can auto-enable
    # it when it isn't wanted
    use kde || export KDEDIR=""
    
    need-automake 1.5
    need-autoconf 2.5
    
    kde_src_compile configure make    

}

src_install () {
    
    make install DESTDIR=${D} || die
    make docs DESTDIR=${D} || die

    dodoc ChangeLog INSTALL README TODO
    
}


