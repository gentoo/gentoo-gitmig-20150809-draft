# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bit-Vector/Bit-Vector-6.4.ebuild,v 1.7 2005/04/07 09:20:00 josejx Exp $

inherit perl-module

DESCRIPTION="Efficient bit vector, set of integers and big int math library"
HOMEPAGE="http://search.cpan.org/~stbey/${P}/"
SRC_URI="mirror://cpan//authors/id/S/ST/STBEY/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 s390 sparc x86 ~ppc"
IUSE=""

DEPEND="dev-perl/Carp-Clan"

SRC_TEST="do"
