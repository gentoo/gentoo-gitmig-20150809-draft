# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mafft/mafft-5.861.ebuild,v 1.1 2006/10/21 05:29:23 dberkholz Exp $

inherit toolchain-funcs

DESCRIPTION="Multiple sequence alignments using a variety of algorithms"
HOMEPAGE="http://www.biophys.kyoto-u.ac.jp/~katoh/programs/align/mafft/"
SRC_URI="http://www.biophys.kyoto-u.ac.jp/~katoh/programs/align/mafft/${P}-src.tgz"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"

src_compile() {
	cd src
	emake \
		CC="$(tc-getCC)" \
		CFLAG="${CFLAGS}" \
		|| die "make failed"
}

src_install() {
	exeinto /usr/bin
	doexe scripts/* binaries/*
	dodoc readme
}
