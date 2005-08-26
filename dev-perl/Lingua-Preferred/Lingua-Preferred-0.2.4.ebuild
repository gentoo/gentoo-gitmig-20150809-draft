# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Preferred/Lingua-Preferred-0.2.4.ebuild,v 1.8 2005/08/26 02:23:04 agriffis Exp $

inherit perl-module

DESCRIPTION="Pick a language based on user's preferences"
SRC_URI="http://search.cpan.org/CPAN/authors/id/E/ED/EDAVIS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/EDAVIS/${P}"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"

DEPEND="${DEPEND}
	dev-perl/Log-TraceMessages"
