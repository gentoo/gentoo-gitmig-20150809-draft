# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DT/XML-DT-0.20.ebuild,v 1.5 2002/07/25 04:56:39 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A perl XML down translate module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86"

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.29"

src_install () {
	
	base_src_install
	dohtml DT.html
}
