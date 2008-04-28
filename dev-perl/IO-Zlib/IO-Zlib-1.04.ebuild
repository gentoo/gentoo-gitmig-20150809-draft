# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Zlib/IO-Zlib-1.04.ebuild,v 1.15 2008/04/28 22:18:25 jer Exp $

inherit perl-module

DESCRIPTION="IO:: style interface to Compress::Zlib"
HOMEPAGE="http://search.cpan.org/~tomhughes/"
SRC_URI="mirror://cpan/authors/id/T/TO/TOMHUGHES/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Compress-Zlib
	dev-lang/perl"
