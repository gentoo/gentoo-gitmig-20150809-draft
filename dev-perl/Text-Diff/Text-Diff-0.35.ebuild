# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Diff/Text-Diff-0.35.ebuild,v 1.3 2004/07/14 20:43:45 agriffis Exp $

inherit perl-module

DESCRIPTION="Easily create test classes in an xUnit style."
HOMEPAGE="http://search.cpan.org/~rbs/${P}/"
SRC_URI="http://www.cpan.org/authors/id/R/RB/RBS/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-perl/Algorithm-Diff"
