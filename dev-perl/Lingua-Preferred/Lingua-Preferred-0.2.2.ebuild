# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Preferred/Lingua-Preferred-0.2.2.ebuild,v 1.4 2004/01/20 13:17:44 gustavoz Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Pick a language based on user's preferences"
SRC_URI="http://search.cpan.org/CPAN/authors/id/E/ED/EDAVIS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/EDAVIS/${P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc sparc ~alpha"

DEPEND="${DEPEND}
	dev-perl/Log-TraceMessages"
