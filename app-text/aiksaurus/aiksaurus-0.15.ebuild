# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/aiksaurus/aiksaurus-0.15.ebuild,v 1.2 2002/07/16 03:41:08 owen Exp $

S=${WORKDIR}/Aiksaurus-${PV}
DESCRIPTION="A thesaurus lib, tool and database"
SRC_URI="http://www.aiksaurus.com/dist/TAR/Aiksaurus-${PV}.tar.gz"
HOMEPAGE="http://www.aiksaurus.com/"
SLOT="0"
LICENSE="GPL-2"

DEPEND="sys-devel/gcc"
RDEPEND=""
KEYWORDS="x86 ppc"
src_compile() {
    cd ${S}
    ./configure --prefix=/usr || die
    emake || die
}

src_install() {

    make DESTDIR=${D} install || die

}
