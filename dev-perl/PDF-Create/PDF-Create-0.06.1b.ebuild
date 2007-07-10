# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDF-Create/PDF-Create-0.06.1b.ebuild,v 1.10 2007/07/10 23:33:28 mr_bones_ Exp $

inherit perl-module

MY_P="perl-pdf-${PV}"
MY_PV=${PV/1b/1}
S=${WORKDIR}/perl-pdf-${MY_PV}
DESCRIPTION="PDF::Create allows you to create PDF documents"
SRC_URI="mirror://sourceforge/perl-pdf/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~ftassin/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
