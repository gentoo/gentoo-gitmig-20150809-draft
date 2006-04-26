# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/rcsb-data/rcsb-data-1.700.ebuild,v 1.2 2006/04/26 03:52:37 spyderous Exp $

inherit eutils

MY_PN="pdb-extract"
MY_P="${MY_PN}-v${PV}-prod-src"
DESCRIPTION="Data required to run RCSB PDB applications"
HOMEPAGE="http://sw-tools.pdb.org/apps/PDB_EXTRACT/index.html"
SRC_URI="http://sw-tools.pdb.org/apps/PDB_EXTRACT/${MY_P}.tar.gz"
LICENSE="PDB"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}
	sci-chemistry/pdb-extract"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/respect-bindir.patch
	sed -i \
		-e "s:^\(BINDIR=\).*:\1${ROOT}usr/bin:g" \
		${S}/etc/binary.sh
}

src_compile() {
	emake binary || die "make binary failed"
}

src_install() {
	insinto /usr/lib/rcsb/data/binary
	doins data/binary/*
	insinto /usr/lib/rcsb/data/ascii
	doins data/ascii/*

	echo "RCSBROOT=\"/usr/lib/rcsb\"" > ${T}/env.d
	newenvd ${T}/env.d 50validation
}
