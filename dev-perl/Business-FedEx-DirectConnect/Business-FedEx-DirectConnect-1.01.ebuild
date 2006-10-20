# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Business-FedEx-DirectConnect/Business-FedEx-DirectConnect-1.01.ebuild,v 1.10 2006/10/20 21:45:45 mcummings Exp $

inherit perl-module

DESCRIPTION="Interface to FedEx Ship Manager Direct"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/J/JP/JPOWERS/${P}.readme"

SLOT="0"
IUSE=""
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 x86"

SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
	dev-perl/Tie-StrictHash
	dev-lang/perl"
