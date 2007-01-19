# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-AutoWriter/XML-AutoWriter-0.38.ebuild,v 1.8 2007/01/19 17:19:46 mcummings Exp $

inherit perl-module

DESCRIPTION="DOCTYPE based XML output"
SRC_URI="mirror://cpan/authors/id/R/RB/RBS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rbs/"
IUSE=""
SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~ia64 sparc x86"

DEPEND="dev-perl/XML-Parser
	dev-lang/perl"

SRC_TEST="do"
