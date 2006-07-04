# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Preferred/Lingua-Preferred-0.2.4.ebuild,v 1.11 2006/07/04 11:40:10 ian Exp $

inherit perl-module

DESCRIPTION="Pick a language based on user's preferences"
SRC_URI="mirror://cpan/authors/id/E/ED/EDAVIS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/EDAVIS/${P}"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"

DEPEND="dev-perl/Log-TraceMessages"
RDEPEND="${DEPEND}"