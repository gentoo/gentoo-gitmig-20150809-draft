# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AtExit/AtExit-2.01.ebuild,v 1.3 2004/06/25 00:06:54 agriffis Exp $ 

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="atexit() function to register exit-callbacks"
AUTHOR="BRADAPP"
SRC_URI_BASE="http://www.cpan.org/modules/by-authors/id/B/BR/BRADAPP"
SRC_URI="${SRC_URI_BASE}/${P}.tar.gz"
HOMEPAGE="${SRC_URI_BASE}/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 sparc"

