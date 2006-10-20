# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-WrapI18N/Text-WrapI18N-0.06.ebuild,v 1.14 2006/10/20 20:12:12 kloeri Exp $

inherit perl-module

DESCRIPTION="Line wrapping with support for multibyte, fullwidth, and combining characters and languages without whitespaces between words"
HOMEPAGE="http://search.cpan.org/~kubota/${P}/"
SRC_URI="mirror://cpan/authors/id/K/KU/KUBOTA/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 m68k ~ppc s390 sh sparc x86"
IUSE=""

DEPEND="dev-perl/Text-CharWidth
	dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"
