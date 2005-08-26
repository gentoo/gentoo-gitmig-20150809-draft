# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PerlIO-via-dynamic/PerlIO-via-dynamic-0.11.ebuild,v 1.7 2005/08/26 03:15:23 agriffis Exp $

inherit perl-module

DESCRIPTION="PerlIO::via::dynamic - dynamic PerlIO layers"
SRC_URI="mirror://cpan/authors/id/C/CL/CLKAO/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/PerlIO/${P}.readme"

SLOT="0"
LICENSE="Artistic"
SRC_TEST="do"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc sparc x86"
IUSE=""

DEPEND=">=perl-core/File-Temp-0.14"
