# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/proj/proj-4.6.0.ebuild,v 1.4 2011/07/21 07:02:26 jlec Exp $

inherit eutils

DESCRIPTION="Proj.4 cartographic projection software with updated NAD27 grids"
HOMEPAGE="http://proj.maptools.org/"
SRC_URI="ftp://ftp.remotesensing.org/pub/proj/${P}.tar.gz
	http://proj.maptools.org/dl/${PN}-datumgrid-1.3.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND="app-arch/unzip"

src_unpack() {
	unpack ${P}.tar.gz
	N="${S}/nad"
	cd ${N}
	mv README README.NAD
	unpack ${PN}-datumgrid-1.3.zip
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README NEWS AUTHORS ChangeLog ${N}/README.{NAD,NADUS} || die
	cd nad
	insinto /usr/share/proj
	insopts -m 755
	doins test27 test83 || die
	insopts -m 644
	doins pj_out27.dist pj_out83.dist || die
}
