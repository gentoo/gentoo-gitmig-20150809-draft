# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ANSIColor/Term-ANSIColor-1.12.ebuild,v 1.3 2007/07/03 14:34:20 armin76 Exp $

inherit perl-module

MY_PN="ANSIColor"
MY_P="$MY_PN-$PV"
S="${WORKDIR}/$MY_P"
DESCRIPTION="Color screen output using ANSI escape sequences."
SRC_URI="mirror://cpan/authors/id/R/RR/RRA/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rra/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc sparc x86"
IUSE="test"
SRC_TEST="do"

DEPEND="test? ( dev-perl/Test-Pod )
	dev-lang/perl"
