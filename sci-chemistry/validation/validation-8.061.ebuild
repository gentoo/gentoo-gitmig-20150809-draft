# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/validation/validation-8.061.ebuild,v 1.1 2005/12/19 01:27:20 spyderous Exp $

inherit eutils toolchain-funcs

MY_P="${PN}-v${PV}-prod-src"
DESCRIPTION="Set of tools used by the PDB for processing and checking structure data"
HOMEPAGE="http://sw-tools.pdb.org/apps/VAL/index.html"
SRC_URI="http://sw-tools.pdb.org/apps/VAL/${MY_P}.tar.gz"
LICENSE="PDB"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/respect-flags-and-add-gcc4.patch
	cd ${S}

	sed -i \
		-e "s:^\(CCC=\).*:\1$(tc-getCXX):g" \
		${S}/etc/make.*

#		-e "s:^\(CC=\).*:\1$(tc-getCC):g" \
#		-e "s:^\(F77=\).*:\1${FORTRANC}:g" \
#		-e "s:^\(F77_LINKER=\).*:\1${FORTRANC}:g" \

# Do this with a patch
#	# Respect flags
#	sed -i \
#		-e "s:\(\"OPT=-O\"\):\"C_OPT=\"${CFLAGS}\" CCC_OPT=\"${CXXFLAGS}\" F_OPT=\"${FFLAGS:- -O2}\"\":g" \
#		${S}/Makefile

}

src_compile() {
	emake || die "make failed"
	emake binary || die "make binary failed"
}

src_install() {
	exeinto /usr/bin
	doexe bin/*
	insinto /usr/lib/rcsb/data/binary
	doins data/binary/*
	insinto /usr/lib/rcsb/data/ascii
	doins data/ascii/*

	echo "RCSBROOT=\"/usr/lib/rcsb\"" > ${T}/env.d
	newenvd ${T}/env.d 50validation

	dodoc README-source README
}

pkg_postinst() {
	einfo "The source version does not install PROCHECK."
	einfo "If you require that, you may download it from"
	einfo "http://www.biochem.ucl.ac.uk/~roman/procheck/procheck.html."
}
