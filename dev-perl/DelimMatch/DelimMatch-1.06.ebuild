# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DelimMatch/DelimMatch-1.06.ebuild,v 1.15 2007/01/15 17:22:47 mcummings Exp $

inherit perl-module
MY_P=${P}a

DESCRIPTION="A Perl 5 module for locating delimited substrings with proper nesting"
SRC_URI="mirror://cpan/authors/id/N/NW/NWALSH/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~nwalsh/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""


DEPEND="dev-lang/perl"
