# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Inline/Inline-0.43.ebuild,v 1.2 2002/07/17 04:04:40 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A perl XML down translate module"
SRC_URI="http://www.cpan.org/authors/id/I/IN/INGY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/doc/INGY/Inline-0.43/Inline.pod"

DEPEND="${DEPEND}
	dev-perl/Test-Harness"

src_compile() {

	echo "y" | base_src_compile 
	base_src_test
}


src_install () {
	
	base_src_install
	dohtml DT.html
}
