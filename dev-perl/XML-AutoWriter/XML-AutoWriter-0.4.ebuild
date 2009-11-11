# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-AutoWriter/XML-AutoWriter-0.4.ebuild,v 1.1 2009/11/11 03:36:09 idl0r Exp $

inherit perl-module

DESCRIPTION="DOCTYPE based XML output"
SRC_URI="mirror://cpan/authors/id/P/PE/PERIGRIN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rbs/"
IUSE=""
SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~hppa ~ia64 ~sparc ~x86"

DEPEND="dev-perl/XML-Parser
	dev-lang/perl"

SRC_TEST="do"
