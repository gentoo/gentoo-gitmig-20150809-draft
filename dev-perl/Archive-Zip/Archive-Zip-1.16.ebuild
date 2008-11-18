# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Zip/Archive-Zip-1.16.ebuild,v 1.14 2008/11/18 14:22:37 tove Exp $

inherit perl-module

DESCRIPTION="A wrapper that lets you read Zip archive members as if they were files"
HOMEPAGE="http://search.cpan.org/~smpeters/"
SRC_URI="mirror://cpan/authors/id/S/SM/SMPETERS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND=">=virtual/perl-Compress-Zlib-1.14
	dev-lang/perl"
