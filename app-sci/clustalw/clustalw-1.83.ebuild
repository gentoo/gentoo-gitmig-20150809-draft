# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Gontran Zepeda <gontran@gontran.net>
# $Header: /var/cvsroot/gentoo-x86/app-sci/clustalw/clustalw-1.83.ebuild,v 1.3 2003/09/06 22:23:05 msterret Exp $

DESCRIPTION="Improving the sensitivity of progressive multiple sequence alignment through sequence weighting, position specific gap penalties and weight matrix choice."

# ClustalW is ubiquitous, but this is the contact group.
HOMEPAGE="http://www.embl-heidelberg.de/~seqanal/"

# One source.
SRC_URI="ftp://ftp.ebi.ac.uk/pub/software/unix/clustalw/${PN}${PV}.UNIX.tar.gz"

LICENSE="clustalw"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~alpha"
IUSE=""
DEPEND="virtual/glibc"

S=${WORKDIR}/${PN}${PV}

src_unpack(){
	# let's use gentoo CFLAGS, et al.
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/optimize-${PN}${PV}.patch
}
src_compile() {
	# clustalw uses only makefile. cool: stupid emake tricks.
	EXTRA_EMAKE="-e ${CFLAGS}"
	emake || die
}
src_install() {
	# a mano
	dobin clustalw
	dodoc README clustalw.doc clustalw.ms clustalw_help
}
