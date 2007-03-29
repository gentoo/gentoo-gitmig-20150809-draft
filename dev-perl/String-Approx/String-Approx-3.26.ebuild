# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/String-Approx/String-Approx-3.26.ebuild,v 1.8 2007/03/29 23:29:17 ticho Exp $

inherit perl-module

DESCRIPTION="Perl extension for approximate string matching (fuzzy matching)"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/J/JH/JHI/${P}.tar.gz"

LICENSE="|| ( Artistic LGPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
