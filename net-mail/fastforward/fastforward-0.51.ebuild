# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-mail/fastforward/fastforward-0.51.ebuild,v 1.4 2002/08/01 11:40:16 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Fastforward handles qmail forwarding according to a cdb database"
HOMEPAGE="http://cr.yp.to/fastforward.html"
SRC_URI="http://cr.yp.to/software/fastforward-0.51.tar.gz"

DEPEND="sys-apps/groff"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

src_unpack() {

    cd ${WORKDIR}
    unpack ${P}.tar.gz

    cd ${S}

    echo "gcc ${CFLAGS}" > conf-cc
    echo "gcc" > conf-ld

}

src_compile() {

    cd ${S}

    emake it || die
}



src_install() {                 

    into /usr
    dodoc ALIASES BLURB CHANGES FILES INSTALL README SYSDEPS TARGETS
    dodoc THANKS TODO VERSION
 
    insopts -o root -g qmail -m 755
    insinto /var/qmail/bin
    doins fastforward newaliases newinclude printforward printmaillist \
	setforward setmaillist 

    into /usr
    for i in *.1
    do
        doman $i
    done

}
