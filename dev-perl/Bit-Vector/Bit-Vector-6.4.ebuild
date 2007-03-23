# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bit-Vector/Bit-Vector-6.4.ebuild,v 1.15 2007/03/23 22:57:53 killerfox Exp $

inherit perl-module

DESCRIPTION="Efficient bit vector, set of integers and big int math library"
HOMEPAGE="http://search.cpan.org/~stbey/"
SRC_URI="mirror://cpan//authors/id/S/ST/STBEY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND="dev-perl/Carp-Clan
	dev-lang/perl"

SRC_TEST="do"
