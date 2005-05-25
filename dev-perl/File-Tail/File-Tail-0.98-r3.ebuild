# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Tail/File-Tail-0.98-r3.ebuild,v 1.10 2005/05/25 15:24:31 mcummings Exp $

inherit perl-module

DESCRIPTION="File::Tail module for perl"
SRC_URI="mirror://cpan/authors/id/MGRABNAR/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/MGRABNAR/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND} perl-core/Time-HiRes"

export OPTIMIZE="$CFLAGS"
mydoc="ToDo"
