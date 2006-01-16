# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/FCGI/FCGI-0.67.ebuild,v 1.8 2006/01/16 20:37:03 mcummings Exp $

# this is an RT dependency

inherit perl-module

DESCRIPTION="Fast CGI"
SRC_URI="mirror://cpan/authors/id/S/SK/SKIMO/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/S/SK/SKIMO/${P}.readme"

SRC_TEST="do"
SLOT="0"
LICENSE="openmarket"
KEYWORDS="~amd64 ppc x86"
IUSE=""
