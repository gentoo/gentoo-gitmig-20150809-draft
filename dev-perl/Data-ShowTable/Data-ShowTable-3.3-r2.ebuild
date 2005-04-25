# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-ShowTable/Data-ShowTable-3.3-r2.ebuild,v 1.8 2005/04/25 13:27:02 mcummings Exp $

inherit perl-module

DESCRIPTION="routines to display tabular data in several formats"
SRC_URI="mirror://cpan/authors/id/A/AK/AKSTE/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Data/${P}.readme"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

mydoc="Copyright GNU-LICENSE"

src_install () {

	perl-module_src_install
	dohtml *.html
}
