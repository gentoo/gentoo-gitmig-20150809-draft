# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/readseq/readseq-19930201.ebuild,v 1.4 2004/08/09 21:10:43 ribosome Exp $

DESCRIPTION="Reads and writes nucleic/protein sequences in various formats."
SRC_URI="mirror://debian/pool/main/r/readseq/readseq_11.orig.tar.gz"
HOMEPAGE="http://iubio.bio.indiana.edu/soft/molbio/readseq/"
LICENSE="public-domain"

KEYWORDS="~x86"
SLOT="0"
IUSE=""

S="${WORKDIR}/readseq-1"

src_compile() {
	make -e || die
}

src_install() {
	dobin readseq
	dodoc Readme Readseq.help
}
