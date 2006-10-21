# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageSize/ImageSize-3.0.ebuild,v 1.7 2006/10/21 14:19:07 dertobi123 Exp $

inherit perl-module

MY_P=Image-Size-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Perl Image-Size Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Image/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJRAY/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc ~x86"
IUSE=""

mydoc="ToDo"


DEPEND="dev-lang/perl"
