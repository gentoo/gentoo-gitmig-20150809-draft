# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Cache/Cache-Cache-1.01.ebuild,v 1.1 2002/11/17 03:32:45 mkennedy Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Class-Container module for perl"
SRC_URI="http://www.cpan.org/authors/id/D/DC/DCLINTON/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/D/DC/DCLINTON/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

DEPEND="${DEPEND}
	>=dev-perl/Digest-SHA1-2.01
	>=dev-perl/Error-0.15
	>=dev-perl/Storable-1.0.14"

export OPTIMIZE="$CFLAGS"
