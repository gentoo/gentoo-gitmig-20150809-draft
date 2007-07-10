# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/FCGI/FCGI-0.67.ebuild,v 1.15 2007/07/10 23:33:26 mr_bones_ Exp $

# this is an RT dependency

inherit perl-module

DESCRIPTION="Fast CGI"
SRC_URI="mirror://cpan/authors/id/S/SK/SKIMO/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~skimo/"

SRC_TEST="do"
SLOT="0"
LICENSE="openmarket"
KEYWORDS="amd64 ia64 ppc ~ppc64 x86"
IUSE=""

DEPEND="dev-lang/perl"
