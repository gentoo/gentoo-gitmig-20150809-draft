# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/gmap/gmap-2011.03.28.ebuild,v 1.1 2011/05/21 19:02:40 weaver Exp $

EAPI="2"

MY_PV=${PV//./-}

DESCRIPTION="A Genomic Mapping and Alignment Program for mRNA and EST Sequences"
HOMEPAGE="http://www.gene.com/share/gmap/"
SRC_URI="http://research-pub.gene.com/gmap/src/gmap-gsnap-${MY_PV}.tar.gz"

LICENSE="gmap"
SLOT="0"
IUSE="+samtools"
KEYWORDS="~amd64 ~x86"

DEPEND="samtools? ( sci-biology/samtools )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/gmap-${MY_PV}.v3"

src_configure() {
	econf $(use_with samtools)
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README
}

src_test() {
	emake check || die
}
