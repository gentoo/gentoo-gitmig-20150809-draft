# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Simple/Pod-Simple-3.02.ebuild,v 1.13 2005/08/26 00:05:46 agriffis Exp $

inherit perl-module

DESCRIPTION="framework for parsing Pod"
HOMEPAGE="http://search.cpan.org/~sburke/${P}"
SRC_URI="mirror://cpan/authors/id/S/SB/SBURKE/${P}.tar.gz"

SRC_TEST="do"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=dev-perl/Pod-Escapes-1.04"
