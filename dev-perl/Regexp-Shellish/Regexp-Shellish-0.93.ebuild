# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Regexp-Shellish/Regexp-Shellish-0.93.ebuild,v 1.17 2010/01/11 19:21:39 grobian Exp $

inherit perl-module

DESCRIPTION="Regexp::Shellish - Shell-like regular expressions"
HOMEPAGE="http://search.cpan.org/~rbs/"
SRC_URI="mirror://cpan/authors/id/R/RB/RBS/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
SRC_TEST="do"
KEYWORDS="alpha amd64 ia64 ~mips ~ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

DEPEND="dev-lang/perl"
