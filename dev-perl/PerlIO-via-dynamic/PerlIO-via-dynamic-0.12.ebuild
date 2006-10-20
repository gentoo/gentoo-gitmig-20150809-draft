# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PerlIO-via-dynamic/PerlIO-via-dynamic-0.12.ebuild,v 1.8 2006/10/20 19:55:40 kloeri Exp $

inherit perl-module

DESCRIPTION="PerlIO::via::dynamic - dynamic PerlIO layers"
SRC_URI="mirror://cpan/authors/id/C/CL/CLKAO/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/PerlIO/${P}.readme"

SLOT="0"
LICENSE="Artistic"
SRC_TEST="do"
KEYWORDS="alpha amd64 ia64 ~mips ~ppc sparc ~x86"
IUSE=""

DEPEND=">=virtual/perl-File-Temp-0.14
	dev-lang/perl"
