# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/set-scalar/set-scalar-1.17.ebuild,v 1.2 2003/09/06 22:37:58 msterret Exp $

inherit perl-module
MY_P=Set-Scalar-${PV}
S=${WORKDIR}/${MY_P}
IUSE=""
SLOT="0"

DESCRIPTION="Scalar set operations"
SRC_URI="http://search.cpan.org/CPAN/authors/id/J/JH/JHI/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/JHI/Set-Scalar-1.17/"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}"
RDEPEND="${DEPEND}"
