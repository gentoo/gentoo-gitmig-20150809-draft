# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Builder-Tester/Test-Builder-Tester-1.01.ebuild,v 1.11 2005/08/26 00:20:22 agriffis Exp $

inherit perl-module

DESCRIPTION="Test testsuites that have been built with Test::Builder"
SRC_URI="mirror://cpan/authors/id/M/MA/MARKF/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~markf/${P}/"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"

DEPEND=">=perl-core/Test-Simple-0.47
		dev-perl/module-build"
