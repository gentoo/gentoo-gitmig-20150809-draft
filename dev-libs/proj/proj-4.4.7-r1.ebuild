# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/proj/proj-4.4.7-r1.ebuild,v 1.2 2004/01/12 17:03:20 nerdboy Exp $

S=${WORKDIR}/${P}
N=${S}/nad
DESCRIPTION="Proj.4 cartographic projection software with extra NAD27 grids"
HOMEPAGE="http://proj.maptools.org/"
SRC_URI="http://proj.maptools.org/dl/${P}.tar.gz
	http://proj.maptools.org/dl/proj-nad27-1.1.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/proj-4.4.7-gentoo.patch || die
	cd ${N}
	mv README README.NAD
	TMPDIR=${T}  tar xvzf ${DISTDIR}/proj-nad27-1.1.tar.gz || die
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	insinto /usr/share/proj
	insopts -m 755
	doins nad/test27
	doins nad/test83
	insopts -m 644
	doins nad/pj_out27.dist
	doins nad/pj_out83.dist
	dodoc COPYING README NEWS AUTHORS INSTALL ChangeLog ${N}/README.NAD ${N}/README.NADUS
}
