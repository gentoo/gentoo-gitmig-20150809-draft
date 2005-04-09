# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Diff/Text-Diff-0.35.ebuild,v 1.6 2005/04/09 00:27:22 trapni Exp $

inherit perl-module

DESCRIPTION="Easily create test classes in an xUnit style."
HOMEPAGE="http://search.cpan.org/~rbs/${P}/"
SRC_URI="http://www.cpan.org/authors/id/R/RB/RBS/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~ppc64 ~amd64"
IUSE=""

DEPEND="dev-perl/Algorithm-Diff"
