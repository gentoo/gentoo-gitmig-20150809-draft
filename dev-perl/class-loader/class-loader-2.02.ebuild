# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/class-loader/class-loader-2.02.ebuild,v 1.5 2004/02/26 06:13:28 kumba Exp $

inherit perl-module

MY_P=Class-Loader-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Load modules and create objects on demand"
HOMEPAGE="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.readme"
SRC_URI="http://search.cpan.org/CPAN/authors/id/V/VI/VIPUL/${MY_P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha hppa ~amd64 ~mips"
