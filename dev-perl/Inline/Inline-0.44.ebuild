# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Inline/Inline-0.44.ebuild,v 1.1 2003/05/31 21:05:10 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Write Perl subroutines in other languages"
SRC_URI="http://www.cpan.org/authors/id/I/IN/INGY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/doc/INGY/Inline-0.43/Inline.pod"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}
	dev-perl/Digest-MD5
	dev-perl/Data-Dumper
	dev-perl/File-Spec
	dev-perl/Parse-RecDescent
	dev-perl/Test-Harness"

src_compile() {

	echo "y" | perl-module_src_compile 
	perl-module_src_test
}


src_install () {
	
	perl-module_src_install
	dohtml DT.html
}
