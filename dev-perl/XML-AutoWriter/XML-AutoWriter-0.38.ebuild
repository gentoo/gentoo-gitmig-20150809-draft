# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-AutoWriter/XML-AutoWriter-0.38.ebuild,v 1.7 2006/08/06 01:15:34 mcummings Exp $

inherit perl-module

DESCRIPTION="DOCTYPE based XML output"
SRC_URI="mirror://cpan/authors/id/R/RB/RBS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rbs/${P}/"
IUSE=""
SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~ia64 sparc x86"

DEPEND="dev-perl/XML-Parser
	dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"

