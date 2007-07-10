# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-SPF-Query/Mail-SPF-Query-1.997.ebuild,v 1.17 2007/07/10 23:33:30 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="query Sender Policy Framework for an IP,email,helo"
SRC_URI="mirror://cpan/authors/id/F/FR/FREESIDE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~freeside/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha ~amd64 ~hppa ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=dev-perl/Net-DNS-0.46
	dev-perl/Net-CIDR-Lite
		dev-perl/Sys-Hostname-Long
		dev-perl/URI
	dev-lang/perl"

mydoc="TODO README sample/*"
