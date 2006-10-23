# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/molmol/molmol-2k_p2.ebuild,v 1.8 2006/10/23 04:29:39 je_fro Exp $

inherit eutils toolchain-funcs multilib

MY_PV="${PV/_p/.}.0"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Publication-quality molecular visualization package"
HOMEPAGE="http://hugin.ethz.ch/wuthrich/software/molmol/index.html"
SRC_URI="ftp://ftp.mol.biol.ethz.ch/software/MOLMOL/unix-gzip/${MY_P}-src.tar.gz
	ftp://ftp.mol.biol.ethz.ch/software/MOLMOL/unix-gzip/${MY_P}-doc.tar.gz"
LICENSE="molmol"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""
DEPEND="virtual/motif
	|| ( x11-libs/libXpm virtual/x11 )
	media-libs/mesa
	media-libs/jpeg
	media-libs/tiff
	media-libs/libpng
	sys-libs/zlib"
# Run-time dependencies, same as DEPEND if RDEPEND isn't defined:
#RDEPEND=""
# Yeah, the gz's aren't in a subdir.
S=${WORKDIR}

MMDIR="/usr/$(get_libdir)/molmol"

src_unpack() {
	if ! built_with_use media-libs/mesa motif; then
		msg="Build media-libs/mesa with USE=motif"
		eerror "${msg}"
		die "${msg}"
	fi

	unpack ${A}

	# Patch from http://pjf.net/science/molmol.html, where src.rpm is provided
	epatch ${FILESDIR}/pjf_RH9_molmol2k2.diff

	ln -s makedef.lnx ${S}/makedef

	# 1) The Korn shell is only taken by default because the Bourne shell
	# on DEC systems cannot handle the script.
	# We don't want this needless dependency.
	# 2) Fix up MOLMOLHOME, which determines the directory the binary's in.
	sed -i \
		-e "s:/bin/ksh:/bin/sh:" \
		-e "s:^MOLMOLHOME.*:MOLMOLHOME=${MMDIR}:" \
		${S}/molmol
	# 1) Set CFLAGS.
	# 2) Set compiler.
	sed -i \
		-e "s:^MCFLAGS.*:MCFLAGS = ${CFLAGS}:" \
		-e "s:^CC.*:CC = $(tc-getCC):" \
		${S}/makedef
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	dobin molmol

	EXEDESTTREE=${MMDIR} newexe src/main/molmol molmol.lnx
	INSDESTTREE=${MMDIR} doins -r auxil help macros man setup tips

	dodoc HISTORY README
}
