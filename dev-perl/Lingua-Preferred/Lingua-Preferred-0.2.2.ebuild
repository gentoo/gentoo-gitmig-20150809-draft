# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Preferred/Lingua-Preferred-0.2.2.ebuild,v 1.8 2006/08/05 13:26:32 mcummings Exp $

inherit perl-module

DESCRIPTION="Pick a language based on user's preferences"
SRC_URI="http://search.cpan.org/CPAN/authors/id/E/ED/EDAVIS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/EDAVIS/${P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc sparc ~alpha"
IUSE=""

DEPEND="dev-perl/Log-TraceMessages
	dev-lang/perl"
RDEPEND="${DEPEND}"

