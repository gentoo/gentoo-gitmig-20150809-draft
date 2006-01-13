# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-WrapI18N/Text-WrapI18N-0.06.ebuild,v 1.3 2006/01/13 22:30:28 mcummings Exp $

inherit perl-module

DESCRIPTION="Line wrapping with support for multibyte, fullwidth, and combining characters and languages without whitespaces between words"
SRC_URI="mirror://cpan/authors/id/K/KU/KUBOTA/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kubota/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="sparc x86"

DEPEND="dev-perl/Text-CharWidth"
IUSE=""

SRC_TEST="do"
