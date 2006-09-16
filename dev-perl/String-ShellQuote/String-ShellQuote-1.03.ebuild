# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/String-ShellQuote/String-ShellQuote-1.03.ebuild,v 1.9 2006/09/16 21:32:21 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Quote strings for passing through the shell"
SRC_URI="mirror://cpan/authors/id/R/RO/ROSCH/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rosch/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ~ppc64 sparc ~x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
