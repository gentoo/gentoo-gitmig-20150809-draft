# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-DBI/Template-DBI-2.64.ebuild,v 1.15 2009/12/23 19:34:13 grobian Exp $

inherit perl-module

DESCRIPTION="DBI plugin for the Template Toolkit"
SRC_URI="mirror://cpan/modules/by-module/Template/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/${P}/"
SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-solaris"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl
		dev-perl/DBI
		>=dev-perl/Template-Toolkit-2.15-r1"

src_compile() {
		echo "n" | perl-module_src_compile
}
