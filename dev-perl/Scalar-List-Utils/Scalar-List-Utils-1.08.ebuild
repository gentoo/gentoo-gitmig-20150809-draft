# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Scalar-List-Utils/Scalar-List-Utils-1.08.ebuild,v 1.3 2002/12/15 10:44:16 bjb Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Scalar-List-Utils module for perl"
SRC_URI="http://cpan.org/modules/by-module/Scalar/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/Scalar/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND}"
