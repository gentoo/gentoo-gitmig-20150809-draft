# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/molmol/molmol-2k_p2.ebuild,v 1.16 2011/06/26 08:21:31 jlec Exp $

EAPI=2

inherit eutils multilib toolchain-funcs

MY_PV="${PV/_p/.}.0"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Publication-quality molecular visualization package"
HOMEPAGE="http://hugin.ethz.ch/wuthrich/software/molmol/index.html"
SRC_URI="
	ftp://ftp.mol.biol.ethz.ch/software/MOLMOL/unix-gzip/${MY_P}-src.tar.gz
	ftp://ftp.mol.biol.ethz.ch/software/MOLMOL/unix-gzip/${MY_P}-doc.tar.gz"

LICENSE="molmol"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="
	media-libs/mesa[motif]
	media-libs/libpng
	media-libs/tiff
	sys-libs/zlib
	virtual/jpeg
	x11-libs/libXpm
	>=x11-libs/openmotif-2.3:0"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

MMDIR="/usr/$(get_libdir)/molmol"

src_prepare() {
	# Patch from http://pjf.net/science/molmol.html, where src.rpm is provided
	epatch "${FILESDIR}"/pjf_RH9_molmol2k2.diff

	ln -s makedef.lnx "${S}"/makedef

	# 1) The Korn shell is only taken by default because the Bourne shell
	# on DEC systems cannot handle the script.
	# We don't want this needless dependency.
	# 2) Fix up MOLMOLHOME, which determines the directory the binary's in.
	sed -i \
		-e "s:/bin/ksh:/bin/sh:" \
		-e "s:^MOLMOLHOME.*:MOLMOLHOME=${MMDIR}:" \
		"${S}"/molmol
	# 1) Set CFLAGS.
	# 2) Set compiler.
	sed -i \
		-e "s:^MCFLAGS.*:MCFLAGS = ${CFLAGS}:" \
		-e "s:^CC.*:CC = $(tc-getCC):" \
		"${S}"/makedef
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	dobin molmol || die

	exeinto ${MMDIR}
	newexe src/main/molmol molmol.lnx || die
	insinto ${MMDIR}
	doins -r auxil help macros man setup tips || die

	dodoc HISTORY README || die
}
