# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/List-MoreUtils/List-MoreUtils-0.19.ebuild,v 1.1 2006/04/20 02:24:45 mcummings Exp $

inherit perl-module

DESCRIPTION="Provide the missing functionality from List::Util"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/V/VP/VPARSEVAL/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"
