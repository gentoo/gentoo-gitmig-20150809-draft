# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Diff/Text-Diff-0.35.ebuild,v 1.5 2004/12/23 08:30:45 nigoro Exp $

inherit perl-module

DESCRIPTION="Easily create test classes in an xUnit style."
HOMEPAGE="http://search.cpan.org/~rbs/${P}/"
SRC_URI="http://www.cpan.org/authors/id/R/RB/RBS/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~ppc64"
IUSE=""

DEPEND="dev-perl/Algorithm-Diff"
