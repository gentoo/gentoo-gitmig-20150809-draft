# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Data-Inheritable/Class-Data-Inheritable-0.02.ebuild,v 1.10 2005/07/09 22:45:14 swegener Exp $

inherit perl-module

DESCRIPTION="Exception::Class module for perl"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MS/MSCHWERN/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

export OPTIMIZE="${CFLAGS}"
