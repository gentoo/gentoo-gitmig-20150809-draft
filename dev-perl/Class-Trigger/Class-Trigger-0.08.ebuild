# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Trigger/Class-Trigger-0.08.ebuild,v 1.2 2004/05/02 12:53:18 mcummings Exp $

inherit perl-module

DESCRIPTION="Mixin to add / call inheritable triggers"
HOMEPAGE="http://search.cpan.org/~miyagawa/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/MI/MIYAGAWA/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86"
SRC_TEST="do"

DEPEND="dev-perl/Test-Simple
		dev-perl/IO-stringy
		dev-perl/Class-Data-Inheritable"
