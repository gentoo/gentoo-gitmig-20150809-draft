# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Reform/Text-Reform-1.11.ebuild,v 1.1 2005/07/24 13:56:29 mcummings Exp $

inherit perl-module

DESCRIPTION="Manual text wrapping and reformatting"
HOMEPAGE="http://search.cpan.org/~dconway/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DC/DCONWAY/${P}.tar.gz"

LICENSE="Artistic"
#LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"
