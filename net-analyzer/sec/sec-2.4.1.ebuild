# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sec/sec-2.4.1.ebuild,v 1.1 2008/01/15 15:52:45 jokey Exp $

DESCRIPTION="Simple Event Correlator"
HOMEPAGE="http://simple-evcorr.sourceforge.net/"
SRC_URI="mirror://sourceforge/simple-evcorr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.0"

src_install() {
	dobin sec.pl

	dodoc ChangeLog README
	docinto contrib
	dodoc contrib/{itostream.c,convert.pl,swatch2sec.pl}

	newman sec.pl.man sec.pl.1

	newinitd "${FILESDIR}"/sec.init.d sec
	newconfd "${FILESDIR}"/sec.conf.d sec
}
