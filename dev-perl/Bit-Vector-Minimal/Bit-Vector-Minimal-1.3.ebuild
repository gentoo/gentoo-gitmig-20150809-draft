# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bit-Vector-Minimal/Bit-Vector-Minimal-1.3.ebuild,v 1.1 2005/11/09 13:28:13 mcummings Exp $

inherit perl-module

DESCRIPTION="Object-oriented wrapper around vec()"
HOMEPAGE="http://search.cpan.org/~simon/${P}/"
SRC_URI="mirror://cpan/authors/id/T/TM/TMTM/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

SRC_TEST="do"
