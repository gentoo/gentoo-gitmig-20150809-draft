# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-Map/Unicode-Map-0.112.ebuild,v 1.1 2004/06/06 15:43:10 mcummings Exp $

inherit perl-module

DESCRIPTION="map charsets from and to utf16 code"
SRC_URI="http://search.cpan.org/CPAN/authors/id/M/MS/MSCHWARTZ/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/~mschwartz/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

SRC_TEST="do"
