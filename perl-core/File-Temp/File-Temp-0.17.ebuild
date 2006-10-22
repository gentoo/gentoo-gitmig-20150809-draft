# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/File-Temp/File-Temp-0.17.ebuild,v 1.7 2006/10/22 00:02:56 kloeri Exp $

inherit perl-module

DESCRIPTION="File::Temp can be used to create and open temporary files in a safe way."
HOMEPAGE="http://search.cpan.org/~tjenness/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TJ/TJENNESS/${P}.tar.gz"
SRC_TEST="do"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc ~ppc64 sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
