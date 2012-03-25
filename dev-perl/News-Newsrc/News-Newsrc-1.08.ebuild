# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/News-Newsrc/News-Newsrc-1.08.ebuild,v 1.14 2012/03/25 16:49:18 armin76 Exp $

inherit perl-module

DESCRIPTION="Manage newsrc files"
SRC_URI="mirror://cpan/authors/id/S/SW/SWMCD/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~swmcd/"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~hppa ~ppc x86"
SRC_TEST="do"
DEPEND=">=dev-perl/Set-IntSpan-1.07
	dev-lang/perl"
