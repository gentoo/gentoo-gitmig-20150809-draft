# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-ShareLite/IPC-ShareLite-0.08.ebuild,v 1.11 2005/03/22 13:28:05 mcummings Exp $

inherit perl-module

DESCRIPTION="IPC::ShareLite module for perl"
SRC_URI="http://www.cpan.org/authors/id/M/MA/MAURICE/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MA/MAURICE/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND}"

export OPTIMIZE="$CFLAGS"

src_compile() {
	echo "" | perl-module_src_compile
}
