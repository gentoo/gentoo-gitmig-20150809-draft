# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/File-Temp/File-Temp-0.18.ebuild,v 1.10 2009/12/16 21:49:14 abcd Exp $

inherit perl-module

DESCRIPTION="File::Temp can be used to create and open temporary files in a safe way."
HOMEPAGE="http://search.cpan.org/~tjenness/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TJ/TJENNESS/${P}.tar.gz"
SRC_TEST="do"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

DEPEND="dev-lang/perl"
