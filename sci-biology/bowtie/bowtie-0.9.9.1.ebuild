# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bowtie/bowtie-0.9.9.1.ebuild,v 1.2 2009/04/23 19:15:58 maekke Exp $

DESCRIPTION="An ultrafast memory-efficient short read aligner"
HOMEPAGE="http://bowtie-bio.sourceforge.net/"
SRC_URI="mirror://sourceforge/bowtie-bio/${P}-src.zip"

LICENSE="Artistic"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86"

DEPEND="app-arch/unzip"
RDEPEND=""

# NB: Bundles code from Maq (http://maq.sf.net) and the SeqAn library (http://www.seqan.de)

src_unpack() {
	unpack ${A}
	sed -i 's/$(CXX) $(RELEASE_FLAGS)/$(CXX) $(CXXFLAGS) $(RELEASE_FLAGS)/' "${S}/Makefile" || die
}

src_install() {
	dobin bowtie bowtie-* || die
	newman MANUAL bowtie.1
	dodoc AUTHORS NEWS TUTORIAL
}
