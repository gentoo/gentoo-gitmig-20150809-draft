# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DelimMatch/DelimMatch-1.06.ebuild,v 1.19 2011/08/17 16:44:27 chithanh Exp $

inherit perl-module
MY_P=${P}a

DESCRIPTION="A Perl 5 module for locating delimited substrings with proper nesting"
SRC_URI="mirror://cpan/authors/id/N/NW/NWALSH/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~nwalsh/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

DEPEND="dev-lang/perl"
