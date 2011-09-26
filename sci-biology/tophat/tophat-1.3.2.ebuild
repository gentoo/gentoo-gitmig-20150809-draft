# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/tophat/tophat-1.3.2.ebuild,v 1.1 2011/09/26 15:33:22 weaver Exp $

EAPI=4

DESCRIPTION="A fast splice junction mapper for RNA-Seq reads"
HOMEPAGE="http://tophat.cbcb.umd.edu/"
SRC_URI="http://tophat.cbcb.umd.edu/downloads/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE="+bam"
KEYWORDS="~amd64 ~x86"

DEPEND="bam? ( sci-biology/samtools )"
RDEPEND="${DEPEND}
	sci-biology/bowtie"

MAKEOPTS="${MAKEOPTS} -j1"

src_configure() {
	econf \
		$(use_with bam) || die
}

src_install() {
	einstall || die
	dodoc AUTHORS NEWS THANKS
}
