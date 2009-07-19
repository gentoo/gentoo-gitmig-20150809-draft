# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Zip/Archive-Zip-1.16.ebuild,v 1.15 2009/07/19 17:32:10 tove Exp $

inherit perl-module

DESCRIPTION="A wrapper that lets you read Zip archive members as if they were files"
HOMEPAGE="http://search.cpan.org/~smpeters/"
SRC_URI="mirror://cpan/authors/id/S/SM/SMPETERS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=virtual/perl-IO-Compress-1.14
	dev-lang/perl"
