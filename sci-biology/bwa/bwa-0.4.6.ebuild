# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bwa/bwa-0.4.6.ebuild,v 1.2 2009/06/07 16:19:55 flameeyes Exp $

EAPI=2

DESCRIPTION="Burrows-Wheeler Alignment Tool, a fast short genomic sequence aligner"
HOMEPAGE="http://maq.sourceforge.net/"
SRC_URI="mirror://sourceforge/maq/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

DEPEND=""
RDEPEND=""

src_prepare() {
	sed -i 's/^CFLAGS=/CFLAGS+=/' "${S}/Makefile"
}

src_install() {
	dobin bwa || die
	doman bwa.1 || die
	exeinto /usr/share/${PN}
	doexe solid2fastq.pl || die
	dodoc ChangeLog NEWS
}
