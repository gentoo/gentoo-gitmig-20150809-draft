# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/AtExit/AtExit-2.01.ebuild,v 1.15 2010/02/03 00:42:19 hanno Exp $

inherit perl-module

DESCRIPTION="atexit() function to register exit-callbacks"
AUTHOR="BRADAPP"
SRC_URI_BASE="mirror://cpan/authors/id/B/BR/BRADAPP"
SRC_URI="${SRC_URI_BASE}/${P}.tar.gz"
HOMEPAGE="http://mirror.datapipe.net/CPAN/authors/id/B/BR/BRADAPP/"

SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""
DEPEND="dev-lang/perl"
