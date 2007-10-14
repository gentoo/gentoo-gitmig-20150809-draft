# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-db/foomatic-db-20070508.ebuild,v 1.3 2007/10/14 14:01:09 genstef Exp $

DESCRIPTION="Printer information files for foomatic-db-engine to generate ppds"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://gentooexperimental.org/~calchan/distfiles/${PN}-3.0-${PV}.tar.gz
	http://linuxprinting.org/download/foomatic/${PN}-3.0-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="net-print/foomatic-db-engine"

src_compile() {
	econf --disable-gzip-ppds --disable-ppds-to-cups || die "econf failed"
	# ppd files do not belong to this package
	rm -r db/source/PPD
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README TODO USAGE

	# Avoid collision with foo2zjs, bug 185486
	rm ${D}/usr/share/foomatic/db/source/{driver/foo2{hp,lava,xqx,zjs}.xml,printer/{Generic-ZjStream_Printer,HP-{Color_LaserJet_{1500,1600,2600n},LaserJet_{10{00,05,18,20,22},M1005_MFP}},Minolta-{Color_PageWorks_Pro_L,magicolor_2{20,30,43}0_DL},Samsung-CLP-{3,6}00}.xml}
}
