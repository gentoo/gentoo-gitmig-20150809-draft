# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/tree-puzzle/tree-puzzle-5.1.ebuild,v 1.3 2005/01/14 22:54:27 j4rg0n Exp $

DESCRIPTION="Maximum likelihood analysis for nucleotide, amino acid, and two-state data."
HOMEPAGE="http://www.tree-puzzle.de"
SRC_URI="http://www.tree-puzzle.de/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="x86 ~ppc ppc-macos"
IUSE=""

src_compile() {
	econf || die "Configuration failed."
	emake || die "Compilation failed."
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING README

	# User manual
	dohtml doc/{*.html,*.gif}
	insinto /usr/share/doc/${PF}/pdf
	doins doc/*.pdf

	# Example data files
	insinto /usr/share/${PN}/data
	doins data/{*.3trees,*.a,*.b,*.phy,*.n}

	# Program logos
	insinto /usr/share/${PN}/graphics
	doins doc/{*.png,*.eps}
}
