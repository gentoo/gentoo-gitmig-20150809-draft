# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Builder-Tester/Test-Builder-Tester-1.01.ebuild,v 1.6 2005/04/07 20:47:56 hansmi Exp $

inherit perl-module

DESCRIPTION="Test testsuites that have been built with Test::Builder"
SRC_URI="mirror://cpan/authors/id/M/MA/MARKF/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~markf/${P}/"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ppc sparc ~alpha ~ppc64"

DEPEND=">=dev-perl/Test-Simple-0.47
		dev-perl/module-build"
