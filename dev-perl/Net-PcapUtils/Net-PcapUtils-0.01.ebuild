# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-PcapUtils/Net-PcapUtils-0.01.ebuild,v 1.12 2006/08/05 19:29:13 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl Net::PcapUtils - Net::Pcap library utils"
SRC_URI="mirror://cpan/authors/id/T/TI/TIMPOTTER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Net/${P}.readme"
IUSE=""
DEPEND="dev-perl/Net-Pcap
	dev-lang/perl"
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ppc x86"

