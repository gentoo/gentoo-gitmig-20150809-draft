# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/phylip/phylip-3.5.ebuild,v 1.1 2003/04/24 00:09:33 avenj Exp $

DESCRIPTION="PHYLIP (the PHYLogeny Inference Package) is a package of programs for inferring phylogenies (evolutionary trees)"

HOMEPAGE="http://evolution.genetics.washington.edu/phylip.html"
SRC_URI="ftp://evolution.genetics.washington.edu/pub/phylip/${PN}.tar.Z"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

src_compile() {
    cd ${WORKDIR}
	# uses only makefile. 
	EXTRA_EMAKE="-e ${CFLAGS}"
	emake || die
}
src_install() 
{
	cd ${WORKDIR}
	dobin clique consense contml contrast dnacomp dnadist dnainvar 
	dobin dnaml dnamlk dnamove dnapars dnapenny dollop dolmove dolpenny 
	dobin drawgram drawtree factor fitch gendist kitsch mix move neighbor
	dobin penny protdist protpars restml retree seqboot

	dodoc README clique.doc dnadist.doc dolmove.doc
	dodoc kitsch.doc protml.doc consense.doc dnainvar.doc  
	dodoc dolpenny.doc main.doc protpars.doc contchar.doc  
	dodoc dnaml.doc draw.doc makeinf.doc restml.doc contml.doc 
	dodoc dnamlk.doc drawgram.doc
	dodoc mix.doc retree.doc contrast.doc dnamove.doc drawtree.doc  
	dodoc move.doc seqboot.doc discrete.doc dnapars.doc factor.doc    
	dodoc neighbor.doc  sequence.doc distance.doc  dnapenny.doc  fitch.doc
	dodoc penny.doc dnacomp.doc   dollop.doc    gendist.doc   protdist.doc 
}
