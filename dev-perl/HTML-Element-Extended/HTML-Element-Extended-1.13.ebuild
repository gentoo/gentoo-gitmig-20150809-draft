# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Element-Extended/HTML-Element-Extended-1.13.ebuild,v 1.2 2005/11/25 21:37:00 corsair Exp $

inherit perl-module

DESCRIPTION="Extension for manipulating a table composed of HTML::Element style components."
HOMEPAGE="http://search.cpan.org/search?module=${PN}"
SRC_URI="mirror://cpan/authors/id/M/MS/MSISK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/HTML-Tree-3.01"
