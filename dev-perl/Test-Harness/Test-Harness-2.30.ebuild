# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Harness/Test-Harness-2.30.ebuild,v 1.6 2004/03/20 10:23:15 kumba Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Runs perl standard test scripts with statistics"
SRC_URI="http://www.cpan.org/authors/id/P/PE/PETDANCE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Harness"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~amd64 ~ppc sparc ~alpha ~hppa mips"

DEPEND="|| ( dev-perl/File-Spec >=dev-lang/perl-5.8.0-r12 )"

mydoc="rfc*.txt"

src_compile() {
	perl-module_src_compile
}
