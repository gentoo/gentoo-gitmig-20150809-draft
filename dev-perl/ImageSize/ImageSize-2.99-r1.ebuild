# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageSize/ImageSize-2.99-r1.ebuild,v 1.4 2003/02/13 11:11:59 vapier Exp $

inherit perl-module

MY_P=Image-Size-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Perl Image-Size Module"
SRC_URI="http://www.cpan.org/modules/by-module/Image/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Image/${MY_P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 sparc ~alpha ~ppc"

DEPEND="${DEPEND}"

mydoc="ToDo"
