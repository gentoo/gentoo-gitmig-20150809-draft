# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/ncbi-tools/ncbi-tools-04222003-r1.ebuild,v 1.1 2003/05/05 19:36:21 avenj Exp $

DESCRIPTION="NCBI toolkit including the BLAST group of programs, entrez, ddv, udv, sequin and others"
HOMEPAGE="http://www.ncbi.nlm.nih.gov/"

SRC_URI="ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/CURRENT/ncbi.tar.gz ftp://ftp.ncbi.nih.gov/toolbox/ncbi_tools/CURRENT/data.tar.gz"

LICENSE="freedist"
SLOT="0"

KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="X"

DEPEND="app-shells/tcsh 
	X? ( >=xfree-4.3.0 >=x11-libs/openmotif-2.2.2 media-libs/libpng )"
		
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
	dodoc * images/* fa2htgs/*

	# ncbirc file
	dodir /etc/skel
	insinto /etc/skel
	newins ${FILESDIR}/dot-ncbirc .ncbirc

	# env file
	dodir /etc/env.d
	insinto /etc/env.d
	doins ${FILESDIR}/21ncbi
}

pkg_postinst() {
	einfo " "
	einfo "You'll need to edit ${FILESDIR}/21ncbi and indicate where your"
	einfo "formatdb formatted databases are going to live on the filesystem."
	einfo "Additionally, you may want to copy /etc/skel/.ncbirc to your"
	einfo "current users home directories."
	einfo " "
	einfo "Be sure to see the ${P} doc directory!"
	einfo " "
}
