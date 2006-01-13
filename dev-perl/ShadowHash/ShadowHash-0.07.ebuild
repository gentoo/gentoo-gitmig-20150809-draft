# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ShadowHash/ShadowHash-0.07.ebuild,v 1.3 2006/01/13 22:18:37 mcummings Exp $

inherit perl-module

DESCRIPTION="Merge multiple data sources into a hash"
SRC_URI="mirror://cpan/authors/id/R/RR/RRA/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RR/RRA/${P}.readme"
IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="sparc x86"

SRC_TEST="do"
