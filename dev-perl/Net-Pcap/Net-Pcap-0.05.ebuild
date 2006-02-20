# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Pcap/Net-Pcap-0.05.ebuild,v 1.5 2006/02/20 19:38:21 jokey Exp $

inherit perl-module

DESCRIPTION="Perl Net::Pcap - Perl binding to the LBL pcap"
SRC_URI="mirror://cpan/authors/id/K/KC/KCARNUT/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Net/${P}.readme"
IUSE=""
DEPEND="net-libs/libpcap"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ppc sparc x86"
