# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Simple/Email-Simple-1.990.ebuild,v 1.4 2006/10/21 14:23:44 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Simple parsing of RFC2822 message format and headers"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rjbs/"

LICENSE="Artistic"
KEYWORDS="alpha amd64 ppc sparc ~x86"
IUSE=""

SRC_TEST="do"
SLOT="0"

DEPEND="dev-lang/perl"
