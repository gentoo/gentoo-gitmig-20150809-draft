# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/otter/otter-3.2.ebuild,v 1.3 2004/06/24 22:13:53 agriffis Exp $

DESCRIPTION="An Automated Deduction System."
SRC_URI="http://www-unix.mcs.anl.gov/AR/${PN}/${P}.tar.gz"
HOMEPAGE="http://www-unix.mcs.anl.gov/AR/otter/"

KEYWORDS="x86"
LICENSE="otter"
SLOT="0"
IUSE=""
DEPEND="virtual/glibc"
S=${WORKDIR}/${P}/source
WORK=${WORKDIR}/${P}


src_compile() {
	cd ${S}
	emake || die
	cd ${S}/mace
	emake || die
}

src_install() {
	cd ${S}
	dobin otter mace/mace formed/formed
	cd ${WORK}
	dodoc README Legal Copying Changelog documents/*
}

