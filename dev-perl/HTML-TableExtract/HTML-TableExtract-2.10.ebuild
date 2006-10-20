# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-TableExtract/HTML-TableExtract-2.10.ebuild,v 1.6 2006/10/20 19:46:04 kloeri Exp $

inherit perl-module

DESCRIPTION="The Perl Table-Extract Module"
SRC_URI="mirror://cpan/authors/id/M/MS/MSISK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/HTML/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""

mydoc="TODO"

DEPEND=">=dev-perl/HTML-Element-Extended-1.16
	dev-perl/HTML-Parser
	dev-lang/perl"
