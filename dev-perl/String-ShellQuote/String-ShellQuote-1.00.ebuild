# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/String-ShellQuote/String-ShellQuote-1.00.ebuild,v 1.11 2006/08/05 23:06:05 mcummings Exp $

inherit perl-module

DESCRIPTION="Quote strings for passing through the shell"
SRC_URI="mirror://cpan/authors/id/R/RO/ROSCH/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rosch/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
