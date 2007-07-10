# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-ShowTable/Data-ShowTable-3.3-r2.ebuild,v 1.13 2007/07/10 23:33:29 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="routines to display tabular data in several formats"
SRC_URI="mirror://cpan/authors/id/A/AK/AKSTE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~akste/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

mydoc="Copyright GNU-LICENSE"

src_install () {

	perl-module_src_install
	dohtml *.html
}

DEPEND="dev-lang/perl"
