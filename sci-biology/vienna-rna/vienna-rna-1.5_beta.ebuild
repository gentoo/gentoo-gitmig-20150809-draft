# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/vienna-rna/vienna-rna-1.5_beta.ebuild,v 1.1 2005/01/09 18:48:37 ribosome Exp $

inherit flag-o-matic

DESCRIPTION="The Vienna RNA Package - RNA secondary structure prediction and comparison"
LICENSE="vienna-rna"
HOMEPAGE="http://www.tbi.univie.ac.at/~ivo/RNA"
SRC_URI="http://www.tbi.univie.ac.at/~ivo/RNA/ViennaRNA-1.5beta.tar.gz"

KEYWORDS="~x86 ~ppc"
SLOT=0
IUSE=""

DEPEND="dev-lang/perl"

S="${WORKDIR}/ViennaRNA-1.5"

src_compile() {
	append-flags "-fPIC"
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D}
	newbin Readseq/readseq readseq-vienna
	dodoc AUTHORS ChangeLog NEWS README THANKS Readseq/Readseq.help
	newdoc Readseq/Readme README.readseq
}
