# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <ben@sistina.com>
# $Header: /var/cvsroot/gentoo-x86/net-irc/epic4/epic4-1.0.1.ebuild,v 1.2 2001/04/20 03:59:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Epic4 IRC Client "
SRC_URI="ftp://epicsol.org/pub/ircii/EPIC4-PRODUCTION/${A}"
HOMEPAGE="http://epicsol.org"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2"

src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share --libexecdir=/usr/lib/misc --host=${CHOST}
    try make

}

src_install () {

    try make prefix=${D}/usr mandir=${D}/usr/share/man libexecdir=${D}/usr/lib/misc install
    rm ${D}/usr/bin/epic
    dosym epic-EPIC4-${PV} /usr/bin/epic
    dodoc BUG_FORM COPYRIGHT README KNOWNBUGS VOTES
    docinto doc
    cd doc
    dodoc *.txt colors EPIC* IRCII_VERSIONS local_vars missing new-load
    dodoc nicknames outputhelp server_groups SILLINESS TS4
}

