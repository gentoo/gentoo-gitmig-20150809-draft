# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-Test/Apache-Test-1.03.ebuild,v 1.2 2003/06/21 21:36:35 drobbins Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Test.pm wrapper with helpers for testing Apache"
SRC_URI="http://search.cpan.org/CPAN/authors/id/S/ST/STAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/STAS/${P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"

DEPEND="net-www/apache"


src_install() {
	# This is to avoid conflicts with a deprecated Apache::Test stepping
	# in and causing problems/install errors
	if [ -f  ${S}/.mypacklist ];
	then
		rm -f ${S}/.mypacklist
	fi
	perl-module_src_install
}
