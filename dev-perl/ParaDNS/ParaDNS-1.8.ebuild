# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ParaDNS/ParaDNS-1.8.ebuild,v 1.1 2009/04/28 07:35:47 jokey Exp $

inherit perl-module

DESCRIPTION="a DNS lookup class for the Danga::Socket framework"
HOMEPAGE="http://search.cpan.org/search?query=ParaDNS&mode=dist"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/ParaDNS-1.8.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Net-DNS
	>=dev-perl/Danga-Socket-1.61
	dev-lang/perl"
RDEPEND="${DEPEND}"