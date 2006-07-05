# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-WrapI18N/Text-WrapI18N-0.06.ebuild,v 1.6 2006/07/05 11:39:50 ian Exp $

inherit perl-module

DESCRIPTION="Line wrapping with support for multibyte, fullwidth, and combining characters and languages without whitespaces between words"
SRC_URI="mirror://cpan/authors/id/K/KU/KUBOTA/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kubota/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ia64 sparc x86"

DEPEND="dev-perl/Text-CharWidth"
RDEPEND="${DEPEND}"
IUSE=""

SRC_TEST="do"