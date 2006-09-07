# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cairo/Cairo-1.00.ebuild,v 1.2 2006/09/07 11:45:31 corsair Exp $

inherit perl-module

S=${WORKDIR}/${P}

DESCRIPTION="Perl interface to the cairo library"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/T/TS/TSCH/${P}.tar.gz"


IUSE=""

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~ppc64 ~x86"

DEPEND="
	x11-libs/cairo
	>=dev-perl/extutils-depends-0.205
	>=dev-perl/extutils-pkgconfig-1.07"
RDEPEND="${DEPEND}"
