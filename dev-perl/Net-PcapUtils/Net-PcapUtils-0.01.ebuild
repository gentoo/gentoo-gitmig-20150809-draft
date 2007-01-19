# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-PcapUtils/Net-PcapUtils-0.01.ebuild,v 1.13 2007/01/19 14:55:31 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl Net::PcapUtils - Net::Pcap library utils"
SRC_URI="mirror://cpan/authors/id/T/TI/TIMPOTTER/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~timpotter/"
IUSE=""
DEPEND="dev-perl/Net-Pcap
	dev-lang/perl"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ppc x86"
