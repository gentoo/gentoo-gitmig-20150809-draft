# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Pcap/Net-Pcap-0.04.ebuild,v 1.6 2005/01/29 21:16:42 dragonheart Exp $

inherit perl-module

DESCRIPTION="Perl Net::Pcap - Perl binding to the LBL pcap"
SRC_URI="http://www.cpan.org/modules/by-module/Net/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Net/${P}.readme"
IUSE=""
DEPEND="virtual/libpcap"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc"
