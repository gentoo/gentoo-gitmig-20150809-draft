# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Simple/Pod-Simple-3.04.ebuild,v 1.4 2006/07/04 19:47:48 ian Exp $

inherit perl-module

DESCRIPTION="framework for parsing Pod"
HOMEPAGE="http://search.cpan.org/~arandal/${P}"
SRC_URI="mirror://cpan/authors/id/A/AR/ARANDAL/${P}.tar.gz"

SRC_TEST="do"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/Pod-Escapes-1.04"
RDEPEND="${DEPEND}"