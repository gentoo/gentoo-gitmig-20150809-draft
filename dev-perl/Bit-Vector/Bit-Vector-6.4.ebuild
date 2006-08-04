# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bit-Vector/Bit-Vector-6.4.ebuild,v 1.13 2006/08/04 22:37:22 mcummings Exp $

inherit perl-module

DESCRIPTION="Efficient bit vector, set of integers and big int math library"
HOMEPAGE="http://search.cpan.org/~stbey/${P}/"
SRC_URI="mirror://cpan//authors/id/S/ST/STBEY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND="dev-perl/Carp-Clan
	dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"
