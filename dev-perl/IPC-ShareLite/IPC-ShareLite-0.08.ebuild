# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-ShareLite/IPC-ShareLite-0.08.ebuild,v 1.1 2002/11/17 03:22:01 mkennedy Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="IPC::ShareLite module for perl"
SRC_URI="http://www.cpan.org/authors/id/M/MA/MAURICE/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MA/MAURICE/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND="${DEPEND}"

export OPTIMIZE="$CFLAGS"


