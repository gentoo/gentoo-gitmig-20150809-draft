# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/micq/micq-0.4.9.4.ebuild,v 1.2 2003/01/31 09:58:03 mholzer Exp $

SRC_URI="http://www.micq.org/source/${P}.tgz"
DESCRIPTION="text based ICQ client with many features"
HOMEPAGE="http://www.micq.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
       
S=${WORKDIR}/${P}

src_compile() {
    econf || die
    emake || die
}	

src_install() {
    make DESTDIR=${D} install || die
}
