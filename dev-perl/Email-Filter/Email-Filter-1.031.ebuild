# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Filter/Email-Filter-1.031.ebuild,v 1.3 2008/01/02 13:12:14 maekke Exp $

inherit perl-module

DESCRIPTION="Simple filtering of RFC2822 message format and headers"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rjbs/"

LICENSE="Artistic"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"
SLOT="0"

DEPEND="dev-lang/perl dev-perl/Email-LocalDelivery dev-perl/Class-Trigger dev-perl/IPC-Run dev-perl/Email-Simple"
