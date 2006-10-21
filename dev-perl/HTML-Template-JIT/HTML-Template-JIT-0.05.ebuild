# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Template-JIT/HTML-Template-JIT-0.05.ebuild,v 1.8 2006/10/21 00:03:26 mcummings Exp $

inherit perl-module

DESCRIPTION="a just-in-time compiler for HTML::Template"
SRC_URI="mirror://cpan/authors/id/S/SA/SAMTREGAR/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/S/SA/SAMTREGAR/${P}.readme"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 sparc ~x86"

DEPEND=">=dev-perl/HTML-Template-2.8
	dev-perl/Inline
	dev-lang/perl"
