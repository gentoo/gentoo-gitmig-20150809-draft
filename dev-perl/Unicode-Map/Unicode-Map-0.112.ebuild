# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-Map/Unicode-Map-0.112.ebuild,v 1.4 2005/04/29 15:43:16 mcummings Exp $

inherit perl-module

DESCRIPTION="map charsets from and to utf16 code"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWARTZ/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/~mschwartz/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~amd64 ~ppc sparc ~alpha"
IUSE=""

SRC_TEST="do"
