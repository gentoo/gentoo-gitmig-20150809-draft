# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-ShowTable/Data-ShowTable-3.3-r2.ebuild,v 1.6 2004/06/25 00:20:38 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl ShowTable Module"
SRC_URI="http://www.cpan.org/modules/by-module/Data/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Data/${P}.readme"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"

mydoc="Copyright GNU-LICENSE"

src_install () {

	perl-module_src_install
	dohtml *.html
}
