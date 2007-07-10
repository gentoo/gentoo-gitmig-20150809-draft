# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ANSIColor/Term-ANSIColor-1.11.ebuild,v 1.12 2007/07/10 23:33:30 mr_bones_ Exp $

inherit perl-module

MY_PN="ANSIColor"
MY_P="$MY_PN-$PV"
DESCRIPTION="Color screen output using ANSI escape sequences."
SRC_URI="mirror://cpan/authors/id/R/RR/RRA/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rra/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE="test"

DEPEND="test? ( dev-perl/Test-Pod )
	dev-lang/perl"
SRC_TEST="do"
S="${WORKDIR}/$MY_P"
