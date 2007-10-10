# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mafft/mafft-6.240.ebuild,v 1.1 2007/10/10 10:23:40 markusle Exp $

inherit toolchain-funcs multilib

DESCRIPTION="Multiple sequence alignments using a variety of algorithms"
HOMEPAGE="http://align.bmr.kyushu-u.ac.jp/mafft/software/"
SRC_URI="http://align.bmr.kyushu-u.ac.jp/mafft/software/${P}-src.tgz"
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
