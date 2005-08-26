# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/class-loader/class-loader-2.03.ebuild,v 1.2 2005/08/26 00:49:55 agriffis Exp $

inherit perl-module

MY_P=Class-Loader-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Load modules and create objects on demand"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/V/VI/VIPUL/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""
