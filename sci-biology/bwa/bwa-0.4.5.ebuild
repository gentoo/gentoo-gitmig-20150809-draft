# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bwa/bwa-0.4.5.ebuild,v 1.1 2009/02/26 22:11:27 weaver Exp $

DESCRIPTION="Burrows-Wheeler Alignment Tool, a fast short genomic sequence aligner"
HOMEPAGE="http://maq.sourceforge.net/"
SRC_URI="mirror://sourceforge/maq/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	sed -i 's/^CFLAGS=/CFLAGS+=/' "${S}/Makefile"
}

src_install() {
	dobin bwa || die
	doman bwa.1 || die
	dodoc ChangeLog NEWS
}
