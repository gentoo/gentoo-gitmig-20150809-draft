# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageSize/ImageSize-2.99.ebuild,v 1.10 2004/07/14 17:58:58 agriffis Exp $

inherit perl-module

MY_P=Image-Size-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Perl Image-Size Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Image/${MY_P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/Image/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 amd64 sparc ~alpha ~ppc"
IUSE=""

mydoc="ToDo"
