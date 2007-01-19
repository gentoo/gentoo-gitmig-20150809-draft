# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PerlIO-via-symlink/PerlIO-via-symlink-0.05.ebuild,v 1.10 2007/01/19 15:23:51 mcummings Exp $

inherit perl-module

DESCRIPTION="PerlIO::via::symlink -  PerlIO layer for symlinks"
SRC_URI="mirror://cpan/authors/id/C/CL/CLKAO/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~clkao/"

SLOT="0"
LICENSE="Artistic"
SRC_TEST="do"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""


DEPEND="dev-lang/perl"
