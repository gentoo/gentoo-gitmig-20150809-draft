# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/set-scalar/set-scalar-1.22.ebuild,v 1.1 2008/08/23 20:50:00 tove Exp $

inherit perl-module
MY_P=Set-Scalar-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Scalar set operations"
SRC_URI="mirror://cpan/authors/id/J/JH/JHI/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/Set-Scalar/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
