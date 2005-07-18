# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDF-Create/PDF-Create-0.06.1b.ebuild,v 1.1 2005/07/18 10:40:36 mcummings Exp $

inherit perl-module

MY_P="perl-pdf-${PV}"
MY_PV=${PV/1b/1}
S=${WORKDIR}/perl-pdf-${MY_PV}
DESCRIPTION="PDF::Create allows you to create PDF documents"
SRC_URI="mirror://sourceforge/perl-pdf/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~ftassin/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""
