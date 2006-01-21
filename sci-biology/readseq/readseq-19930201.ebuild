# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/readseq/readseq-19930201.ebuild,v 1.3 2006/01/21 18:09:40 ribosome Exp $

DESCRIPTION="Reads and writes nucleic/protein sequences in various formats."
SRC_URI="mirror://debian/pool/main/r/readseq/readseq_1.orig.tar.gz"
HOMEPAGE="http://iubio.bio.indiana.edu/soft/molbio/readseq/"
LICENSE="public-domain"

KEYWORDS="~amd64 x86"
SLOT="0"
IUSE=""

S="${WORKDIR}/readseq-1"

src_compile() {
	make -e || die
}

src_install() {
	dobin readseq || die
	dodoc Readme Readseq.help || die
}
