# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/clustalw/clustalw-1.83.ebuild,v 1.7 2004/09/23 23:56:02 vapier Exp $

inherit eutils

DESCRIPTION="Improving the sensitivity of progressive multiple sequence alignment through sequence weighting, position specific gap penalties and weight matrix choice."
HOMEPAGE="http://www.embl-heidelberg.de/~seqanal/"
SRC_URI="ftp://ftp.ebi.ac.uk/pub/software/unix/clustalw/${PN}${PV}.UNIX.tar.gz"

LICENSE="clustalw"
SLOT="0"
KEYWORDS="alpha ppc sparc x86"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}${PV}

src_unpack(){
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/optimize-${PN}${PV}.patch
}

src_compile() {
	emake -e ${CFLAGS} || die
}

src_install() {
	dobin clustalw || die
	dodoc README clustalw.doc clustalw.ms clustalw_help
}
