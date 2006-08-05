# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Builder-Tester/Test-Builder-Tester-1.01.ebuild,v 1.14 2006/08/05 23:16:10 mcummings Exp $

inherit perl-module

DESCRIPTION="Test testsuites that have been built with Test::Builder"
SRC_URI="mirror://cpan/authors/id/M/MA/MARKF/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~markf/${P}/"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"

DEPEND="<perl-core/Test-Simple-0.62
	dev-perl/module-build
	dev-lang/perl"
RDEPEND="${DEPEND}"


