# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Heap/Heap-0.50.ebuild,v 1.4 2003/06/08 07:19:14 rac Exp $

IUSE=""

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Heap - Perl extensions for keeping data partially sorted." 
SRC_URI="http://www.cpan.org/modules/by-module/Heap/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Heap/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}"
