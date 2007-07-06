# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Finance-Quote/Finance-Quote-1.13.ebuild,v 1.5 2007/07/06 16:21:10 armin76 Exp $

inherit perl-module eutils

DESCRIPTION="Get stock and mutual fund quotes from various exchanges"
HOMEPAGE="http://search.cpan.org/~hampton/"
SRC_URI="mirror://cpan/authors/id/H/HA/HAMPTON/${P}.tar.gz"

IUSE=""

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"

SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
	dev-perl/HTML-TableExtract
	dev-perl/Crypt-SSLeay
	dev-lang/perl"

mydoc="TODO"
