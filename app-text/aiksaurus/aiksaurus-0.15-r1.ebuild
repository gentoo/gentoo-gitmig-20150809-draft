# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/app-text/aiksaurus/aiksaurus-0.15.ebuild,v 1.1 2002/05/31 17:54:03 danarmak Exp

inherit flag-o-matic

S=${WORKDIR}/Aiksaurus-${PV}
DESCRIPTION="A thesaurus lib, tool and database"
SRC_URI="http://www.aiksaurus.com/dist/TAR/Aiksaurus-${PV}.tar.gz"
HOMEPAGE="http://www.aiksaurus.com/"
SLOT="0"
LICENSE="GPL-2"

DEPEND="sys-devel/gcc"
RDEPEND=""
KEYWORDS="x86 ppc sparc sparc64"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	patch <${FILESDIR}/${P}-gentoo.patch || die
}
				
src_compile() {

	filter-flags -fno-exceptions

    ./configure --prefix=/usr || die
    emake || die
}

src_install() {

    make DESTDIR=${D} install || die

}
