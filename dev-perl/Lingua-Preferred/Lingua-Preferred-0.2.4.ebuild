# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Preferred/Lingua-Preferred-0.2.4.ebuild,v 1.13 2007/01/16 01:15:29 mcummings Exp $

inherit perl-module

DESCRIPTION="Pick a language based on user's preferences"
SRC_URI="mirror://cpan/authors/id/E/ED/EDAVIS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~edavis/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"

DEPEND="dev-perl/Log-TraceMessages
	dev-lang/perl"
