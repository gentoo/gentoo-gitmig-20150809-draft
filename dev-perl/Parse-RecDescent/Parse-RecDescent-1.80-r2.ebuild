# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-RecDescent/Parse-RecDescent-1.80-r2.ebuild,v 1.5 2002/07/25 04:43:33 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/Parse/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/Parse/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86"

src_install () {
	
	base_src_install
	dohtml -r tutorial
}
