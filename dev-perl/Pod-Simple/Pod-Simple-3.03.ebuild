# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Simple/Pod-Simple-3.03.ebuild,v 1.2 2006/06/12 16:10:41 mcummings Exp $

inherit perl-module

DESCRIPTION="framework for parsing Pod"
HOMEPAGE="http://search.cpan.org/~arandal/${P}"
SRC_URI="mirror://cpan/authors/id/A/AR/ARANDAL/${P}.tar.gz"

SRC_TEST="do"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/Pod-Escapes-1.04"
