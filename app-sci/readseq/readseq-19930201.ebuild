# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/readseq/readseq-19930201.ebuild,v 1.1 2004/07/14 18:29:01 ribosome Exp $

DESCRIPTION="Reads and writes nucleic/protein sequences in various formats."
SRC_URI="http://ftp.debian.org/debian/pool/main/r/readseq/readseq_1.orig.tar.gz"
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
