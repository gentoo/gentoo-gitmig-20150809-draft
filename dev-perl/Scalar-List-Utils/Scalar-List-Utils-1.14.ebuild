# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Scalar-List-Utils/Scalar-List-Utils-1.14.ebuild,v 1.2 2004/06/25 00:58:02 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Scalar-List-Utils module for perl"
SRC_URI="http://cpan.org/modules/by-module/Scalar/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/Scalar/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}"
