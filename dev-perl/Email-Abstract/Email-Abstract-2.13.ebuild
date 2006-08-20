# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Abstract/Email-Abstract-2.13.ebuild,v 1.1 2006/08/20 03:14:05 mcummings Exp $

inherit perl-module

DESCRIPTION="unified interface to mail representations"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJBS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rjbs/"

LICENSE="Artistic"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"
SLOT="0"

DEPEND=">=dev-perl/Class-ISA-0.20
	>=dev-perl/Email-Simple-1.91
	>=dev-perl/Module-Pluggable-1.5
	dev-lang/perl"
