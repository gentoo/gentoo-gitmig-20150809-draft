# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CharWidth/Text-CharWidth-0.04.ebuild,v 1.13 2006/10/20 20:11:14 kloeri Exp $

inherit perl-module

DESCRIPTION="Get number of occupied columns of a string on terminal"
HOMEPAGE="http://search.cpan.org/~kubota/${P}/"
SRC_URI="mirror://cpan/authors/id/K/KU/KUBOTA/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 m68k ~ppc s390 sh sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"
