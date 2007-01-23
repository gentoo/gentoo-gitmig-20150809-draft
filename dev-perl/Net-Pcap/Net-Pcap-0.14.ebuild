# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Pcap/Net-Pcap-0.14.ebuild,v 1.10 2007/01/23 00:08:18 kloeri Exp $

inherit perl-module eutils

DESCRIPTION="Perl Net::Pcap - Perl binding to the LBL pcap"
SRC_URI="mirror://cpan/authors/id/S/SA/SAPER/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/${P}"
IUSE=""
DEPEND="net-libs/libpcap
	dev-perl/IO-Interface
	dev-lang/perl"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha amd64 ~ia64 ppc sparc ~x86"
