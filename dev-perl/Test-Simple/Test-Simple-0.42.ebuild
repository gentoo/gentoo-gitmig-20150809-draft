# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Simple/Test-Simple-0.42.ebuild,v 1.4 2002/07/27 18:27:16 aliz Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Basic utilities for writing tests"
SRC_URI="http://www.cpan.org/authors/id/MSCHWERN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Harness"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86"

mydoc="rfc*.txt"

newdepend ">=dev-perl/Test-Harness-1.23"

src_compile() {
	perl-module_src_compile
	make test || die "Tests didn't work out. Aborting!"
}
