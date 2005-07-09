# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Finance-Quote/Finance-Quote-1.08.ebuild,v 1.12 2005/07/09 23:20:23 swegener Exp $

inherit perl-module

DESCRIPTION="The Perl Finance-Quote Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Finance/${P}.readme"
SRC_URI="mirror://cpan/authors/id/P/PJ/PJF/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="dev-perl/libwww-perl
	dev-perl/HTML-TableExtract"

mydoc="TODO"
