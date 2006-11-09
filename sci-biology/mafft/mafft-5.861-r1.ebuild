# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mafft/mafft-5.861-r1.ebuild,v 1.1 2006/11/09 14:52:49 dberkholz Exp $

inherit toolchain-funcs multilib

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
		PREFIX="/usr/$(get_libdir)/${PN}" \
		CC="$(tc-getCC)" \
		CFLAG="${CFLAGS}" \
		|| die "make failed"
}

src_install() {
	pushd src
	emake PREFIX="${D}usr/$(get_libdir)/${PN}" install || die "install failed"
	popd
	dodoc readme
}
