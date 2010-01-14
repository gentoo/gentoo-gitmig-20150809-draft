# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-German/Text-German-0.06.ebuild,v 1.12 2010/01/14 15:26:13 grobian Exp $

inherit perl-module

DESCRIPTION="German grundform reduction"
HOMEPAGE="http://search.cpan.org/~ulpfr/"
SRC_URI="mirror://cpan/authors/id/U/UL/ULPFR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
