# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/FCGI/FCGI-0.67.ebuild,v 1.7 2005/12/15 20:40:07 dang Exp $

# this is an RT dependency

inherit perl-module

DESCRIPTION="Fast CGI"
SRC_URI="mirror://cpan/authors/id/S/SK/SKIMO/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/S/SK/SKIMO/${P}.readme"

SRC_TEST="do"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ppc x86"
IUSE=""
