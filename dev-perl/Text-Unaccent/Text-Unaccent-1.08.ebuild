# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Unaccent/Text-Unaccent-1.08.ebuild,v 1.1 2005/11/12 13:06:56 mcummings Exp $

inherit perl-module

DESCRIPTION="Removes accents from a string"
HOMEPAGE="http://search.cpan.org/~ldachary/${P}/"
SRC_URI="http://www.cpan.org/authors/id/L/LD/LDACHARY/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~x86 ~sparc ~alpha ~ppc ~amd64"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"
