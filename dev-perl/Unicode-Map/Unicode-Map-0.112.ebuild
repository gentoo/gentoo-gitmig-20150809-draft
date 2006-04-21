# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-Map/Unicode-Map-0.112.ebuild,v 1.10 2006/04/21 21:08:57 gustavoz Exp $

inherit perl-module

DESCRIPTION="map charsets from and to utf16 code"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWARTZ/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/~mschwartz/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha ~amd64 hppa ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"
