# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Data-Inheritable/Class-Data-Inheritable-0.02.ebuild,v 1.6 2004/06/25 00:11:57 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Exception::Class module for perl"
SRC_URI="http://www.cpan.org/authors/id/M/MS/MSCHWERN/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MS/MSCHWERN/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}"

export OPTIMIZE="$CFLAGS"
