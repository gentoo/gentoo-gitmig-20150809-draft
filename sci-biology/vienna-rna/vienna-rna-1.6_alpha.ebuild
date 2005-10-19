# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/vienna-rna/vienna-rna-1.6_alpha.ebuild,v 1.1 2005/10/19 02:52:02 ribosome Exp $

inherit flag-o-matic

DESCRIPTION="The Vienna RNA Package - RNA secondary structure prediction and comparison"
LICENSE="vienna-rna"
HOMEPAGE="http://www.tbi.univie.ac.at/~ivo/RNA"
SRC_URI="http://www.tbi.univie.ac.at/~ivo/RNA/ViennaRNA-1.6alpha.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc"

DEPEND="dev-lang/perl
	virtual/x11
	media-libs/gd"

S="${WORKDIR}/ViennaRNA-1.6"

src_compile() {
	econf --with-cluster --without-forester || die "Configuration failed."
	emake || die "Compilation failed."
}

src_install() {
	make install DESTDIR="${D}" || die "Installation failed."
	newbin Readseq/readseq readseq-vienna || die \
		"Installing programs failed."
	dodoc AUTHORS ChangeLog NEWS README THANKS Readseq/Readseq.help || die \
		"Document installation failed."
	newdoc Readseq/Readme README.readseq || die \
		"Installing Readme failed."
}
