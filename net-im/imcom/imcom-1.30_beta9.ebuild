# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/imcom/imcom-1.30_beta9.ebuild,v 1.1 2003/05/21 04:52:29 lordvan Exp $

MYVER=1.30beta9
S=${WORKDIR}/${PN}-${MYVER}
#SRC_URI="http://imcom.floobin.cx/files/${P}.tar.gz"
SRC_URI="http://nafai.dyndns.org/files/imcom-betas/${PN}-${MYVER}.tar.gz"
HOMEPAGE="http://imcom.floobin.cx"
DESCRIPTION="Python commandline Jabber Client"

DEPEND=">=dev-lang/python-2.2
	>=dev-python/PyXML-0.7"
RDEPEND=""

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
    ./configure --prefix=/usr || die "configure failed"
    #make
    # fixing it ..
    cp ${FILESDIR}/Makefile-1.30_beta8 ${S}/Makefile
    pwd
    make
}

src_install() {
	dodoc AutoStatus.API CONTRIBUTORS LICENSE README* TODO WHATSNEW
	dodoc docs/*
	make MYVER=${MYVER} DESTDIR=${D} install
}
