# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Hook-LexWrap/Hook-LexWrap-0.20.ebuild,v 1.2 2005/06/13 11:11:51 dholm Exp $

inherit perl-module

DESCRIPTION="Lexically scoped subroutine wrappers"
HOMEPAGE="http://search.cpan.org/~dconway/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DC/DCONWAY/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

SRC_TEST="do"
