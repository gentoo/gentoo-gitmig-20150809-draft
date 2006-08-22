# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Tree/HTML-Tree-3.21.ebuild,v 1.1 2006/08/22 17:24:53 ian Exp $

inherit perl-module

DESCRIPTION="A library to manage HTML-Tree in PERL"
SRC_URI="mirror://cpan/authors/id/P/PE/PETEK/${P}.tar.gz"
HOMEPAGE="http://seach.cpan.org/search?module=${P}"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

mydoc="Changes MANIFEST README"
DEPEND=">=dev-perl/HTML-Tagset-3.03
	>=dev-perl/HTML-Parser-2.19
	dev-lang/perl"
RDEPEND="${DEPEND}"
