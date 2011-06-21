# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/proj/proj-4.4.9.ebuild,v 1.11 2011/06/21 15:06:42 jlec Exp $

inherit eutils fortran-2
N=${S}/nad

DESCRIPTION="Proj.4 cartographic projection software with updated NAD27 grids"
HOMEPAGE="http://proj.maptools.org/"
SRC_URI="ftp://ftp.remotesensing.org/pub/proj/${P}.tar.gz
	http://proj.maptools.org/dl/${PN}-nad27-1.2.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND="
	virtual/fortran
	"
RDEPEND=""

src_unpack() {
	unpack ${P}.tar.gz
	cd "${S}"
	epatch "${FILESDIR}"/proj-4.4.7-gentoo.patch || die
	cd ${N}
	mv README README.NAD
	unpack proj-nad27-1.2.tar.gz || die
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
	dodoc README NEWS AUTHORS INSTALL ChangeLog ${N}/README.NAD ${N}/README.NADUS
}
