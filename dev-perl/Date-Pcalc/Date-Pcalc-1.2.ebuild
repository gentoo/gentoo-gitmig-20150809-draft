# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Pcalc/Date-Pcalc-1.2.ebuild,v 1.10 2006/08/05 02:45:31 mcummings Exp $

inherit perl-module

DESCRIPTION="Gregorian calendar date calculations"
SRC_URI="mirror://cpan/authors/id/S/ST/STBEY/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/S/ST/STBEY/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ia64 ppc x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
