# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: 

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Archive::Rar - Interface with the rar command"
SRC_URI="http://www.cpan.org/modules/by-module/Archive/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Acrhive/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}"
