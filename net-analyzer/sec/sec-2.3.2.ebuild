# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sec/sec-2.3.2.ebuild,v 1.2 2007/07/11 23:49:24 mr_bones_ Exp $

DESCRIPTION="Simple Event Correlator"
HOMEPAGE="http://simple-evcorr.sourceforge.net/"
SRC_URI="mirror://sourceforge/simple-evcorr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.0"

src_compile() {
	einfo "Nothing to compile."
}

src_install() {
	dobin sec.pl

	dodoc ChangeLog README sec.startup itostream.c convert.pl

	mv ${S}/sec.pl.man ${S}/sec.pl.1
	doman sec.pl.1
}
