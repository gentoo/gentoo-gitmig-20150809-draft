# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/elph/elph-0.1.2.ebuild,v 1.1 2003/05/22 15:44:09 avenj Exp $

DESCRIPTION="ELPH -- general-purpose Gibbs sampler for finding motifs in a set of DNA or protein sequences"
HOMEPAGE="http://www.tigr.org/software/ELPH/index.shtml"
SRC_URI="ftp://ftp.tigr.org/pub/software/ELPH/ELPH-${PV}.tar.gz"
LICENSE="Artistic"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/ELPH/sources


src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin
	dobin elph

        cd ${WORKDIR}/ELPH/
	dodoc COPYRIGHT  LICENSE  README  Readme.ELPH 
}
