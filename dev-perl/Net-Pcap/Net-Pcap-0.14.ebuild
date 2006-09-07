# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Pcap/Net-Pcap-0.14.ebuild,v 1.2 2006/09/07 15:52:31 yuval Exp $

inherit perl-module eutils

DESCRIPTION="Perl Net::Pcap - Perl binding to the LBL pcap"
SRC_URI="mirror://cpan/authors/id/S/SA/SAPER/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/${P}"
IUSE=""
DEPEND="net-libs/libpcap
	dev-perl/IO-Interface
	dev-lang/perl"
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86"
