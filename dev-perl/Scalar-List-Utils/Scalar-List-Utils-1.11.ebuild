# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Scalar-List-Utils/Scalar-List-Utils-1.11.ebuild,v 1.2 2003/06/21 21:36:37 drobbins Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Scalar-List-Utils module for perl"
SRC_URI="http://cpan.org/modules/by-module/Scalar/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/Scalar/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}"
