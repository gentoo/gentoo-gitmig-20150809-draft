# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/hermes/hermes-1.3.2-r1.ebuild,v 1.2 2002/07/11 06:30:38 drobbins Exp $

PN0=Hermes
S=${WORKDIR}/${PN0}-${PV}
DESCRIPTION="Library necessary for building ClanLib?"
SRC_URI="http://dark.x.dtu.dk/~mbn/clanlib/download/download-sphair/${PN0}-${PV}.tar.gz"
HOMEPAGE="http://hermes.terminal.at"
DEPEND="virtual/glibc 
	sys-devel/automake 
	sys-devel/autoconf 
	sys-devel/libtool"
RDEPEND="virtual/glibc"

src_compile() {
    ./autogen.sh || die
    ./configure --prefix=/usr --host=${CHOST} || die
    sh ltconfig ltmain.sh || die
    emake || die

}

src_install () {

    make prefix=${D}/usr install || die
    dodoc AUTHORS COPYING ChangeLog FAQ NEWS README TODO*
    docinto html
    dodoc docs/api/*.htm
    docinto print
    dodoc docs/api/*.ps
    docinto txt
    dodoc docs/api/*.txt
    docinto sgml
    dodoc docs/api/sgml/*.sgml
}

