# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Algorithm-Annotate/Algorithm-Annotate-0.10.ebuild,v 1.16 2010/01/09 16:21:10 grobian Exp $

inherit perl-module

HOMEPAGE="http://search.cpan.org/~clkao/"
DESCRIPTION="Algorithm::Annotate - represent a series of changes in annotate form"
SRC_URI="mirror://cpan/authors/id/C/CL/CLKAO/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""
SRC_TEST="do"

DEPEND=">=dev-perl/Algorithm-Diff-1.15
	dev-lang/perl"
