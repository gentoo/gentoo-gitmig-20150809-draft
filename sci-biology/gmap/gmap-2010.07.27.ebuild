# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/gmap/gmap-2010.07.27.ebuild,v 1.2 2010/10/11 07:19:50 hwoarang Exp $

EAPI="2"

MY_PV=${PV//./-}

DESCRIPTION="A Genomic Mapping and Alignment Program for mRNA and EST Sequences"
HOMEPAGE="http://www.gene.com/share/gmap/"
SRC_URI="http://research-pub.gene.com/gmap/src/gmap-gsnap-${MY_PV}.tar.gz"

LICENSE="gmap"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ~x86"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/gmap-${MY_PV}"

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README
}

src_test() {
	emake check || die
}
