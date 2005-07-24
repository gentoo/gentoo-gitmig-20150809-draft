# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Reform/Text-Reform-1.11.ebuild,v 1.2 2005/07/24 17:25:23 dholm Exp $

inherit perl-module

DESCRIPTION="Manual text wrapping and reformatting"
HOMEPAGE="http://search.cpan.org/~dconway/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DC/DCONWAY/${P}.tar.gz"

LICENSE="Artistic"
#LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"
