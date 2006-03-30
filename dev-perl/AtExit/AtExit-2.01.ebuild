# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AtExit/AtExit-2.01.ebuild,v 1.9 2006/03/30 22:11:09 agriffis Exp $

inherit perl-module

DESCRIPTION="atexit() function to register exit-callbacks"
AUTHOR="BRADAPP"
SRC_URI_BASE="mirror://cpan/authors/id/B/BR/BRADAPP"
SRC_URI="${SRC_URI_BASE}/${P}.tar.gz"
HOMEPAGE="${SRC_URI_BASE}/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~ia64 ppc sparc x86"
IUSE=""
