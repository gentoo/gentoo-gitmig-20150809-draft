# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Harness/Test-Harness-2.28.ebuild,v 1.10 2004/07/14 20:38:55 agriffis Exp $

inherit perl-module

DESCRIPTION="Runs perl standard test scripts with statistics"
SRC_URI="http://www.cpan.org/authors/id/P/PE/PETDANCE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Harness"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc sparc alpha hppa"
IUSE=""

DEPEND="dev-perl/File-Spec"

mydoc="rfc*.txt"

src_compile() {
	perl-module_src_compile
}
