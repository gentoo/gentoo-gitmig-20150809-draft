# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/samtools/samtools-0.1.12a.ebuild,v 1.2 2011/02/18 05:07:16 weaver Exp $

EAPI="2"

DESCRIPTION="Utilities for SAM (Sequence Alignment/Map), a format for large nucleotide sequence alignments"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86 ~x64-macos"

DEPEND=""
RDEPEND=""

src_prepare() {
	sed -i 's/^CFLAGS=/CFLAGS+=/' "${S}"/{Makefile,misc/Makefile} || die
	sed -i 's~/software/bin/python~/usr/bin/env python~' "${S}"/misc/varfilter.py || die
}

src_compile() {
	emake dylib || die
	emake || die
}

src_install() {
	dobin samtools || die
	dobin $(find misc -type f -executable) || die
	dolib.so libbam.so.1 || die
	insinto /usr/include/bam
	doins bam.h bgzf.h faidx.h kaln.h khash.h kprobaln.h kseq.h ksort.h sam.h|| die
	insinto /usr/share/${PN}
	doins -r examples || die
	doman ${PN}.1 || die
	dodoc AUTHORS ChangeLog NEWS
}
