# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Container/Class-Container-0.10.ebuild,v 1.3 2003/12/25 21:00:48 weeve Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Class-Container module for perl"
SRC_URI="http://www.cpan.org/authors/id/K/KW/KWILLIAMS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MS/MSCHWERN/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~ppc sparc ~alpha"

DEPEND="${DEPEND}
	>=dev-perl/Params-Validate-0.24-r1
	>=dev-perl/Scalar-List-Utils-1.08"
