# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/FCGI/FCGI-0.67.ebuild,v 1.3 2004/09/02 13:28:37 dholm Exp $

# this is an RT dependency

inherit perl-module

DESCRIPTION="Fast CGI"
SRC_URI="http://www.cpan.org/modules/by-authors/id/S/SK/SKIMO/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/S/SK/SKIMO/${P}.readme"

SRC_TEST="do"
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""
