# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/File-Temp/File-Temp-0.18.ebuild,v 1.7 2007/08/12 20:14:46 tgall Exp $

inherit perl-module

DESCRIPTION="File::Temp can be used to create and open temporary files in a safe way."
HOMEPAGE="http://search.cpan.org/~tjenness/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TJ/TJENNESS/${P}.tar.gz"
SRC_TEST="do"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl"
