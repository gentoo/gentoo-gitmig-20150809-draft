# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ncbi-tools/ncbi-tools-04222003.ebuild,v 1.1 2003/05/04 02:37:49 avenj Exp $

DESCRIPTION="NCBI toolkit including the BLAST group of programs, entrez, ddv, udv, sequin and others"
HOMEPAGE="http://www.ncbi.nlm.nih.gov/"

SRC_URI="ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/CURRENT/ncbi.tar.gz ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/CURRENT/data.tar.gz"

LICENSE="freedist"
SLOT="0"

KEYWORDS="~x86"
IUSE="X"

DEPEND="X? ( >=xfree-4.3.0 
	     >=openmotif-2.2.2 )"
		
S=${WORKDIR}/${P}

src_compile() {
	
	cd ${WORKDIR}
	# NCBI provides their own compile script where they check for
	# the existence of X (openmotif and opengl) libs and compile in support 
	# if they exist 

	# future ebuilds will allow for -X which will not compile any of the
	# graphical tools.  But for right now you get everything if you have 
	# X installed

	./ncbi/make/makedis.csh 2>&1 | tee out.makedis.txt

}

src_install() {

	cd ${WORKDIR}/ncbi/bin
	dobin Nentrez blastclust entrcmd getmesh megablast testobj Psequin blastpgp entrez2 getpub ncbisort testval asn2ff cdscan errhdr getseq netentcf udv asn2gb checksub fa2htgs gil2bin rpsblast vecscreen asn2xml copymat fastacmd idfetch seedtop asndhuff ddv findspl impala seqtest asntool demo_regexp fmerge indexpub tbl2asn blastall demo_regexp_grep formatdb makemat test_regexp blastcl3 dosimple getfeat makeset testcore
	

	cd ${WORKDIR}
	dodir /usr/var/ncbi
        insinto /usr/var/ncbi
        doins data/*

	dodoc README README.htm VERSION checkout.date
	
	cd ${WORKDIR}/ncbi/doc
	dodoc *
}

pkg_postinst() {
    einfo "--------------------------"
    einfo "You must create a .ncbirc file "
	einfo "for the majority of these programs"
	einfo "to work right"
	einfo " "
    einfo "See README.bls for more information"
    einfo "--------------------------"
    einfo "The file should contain the two following lines:"
    einfo "[NCBI]"
    einfo "Data=/usr/var/ncbi"
    einfo "--------------------------"
	einfo " "
	einfo "It should be placed in the user's home directory"
}
