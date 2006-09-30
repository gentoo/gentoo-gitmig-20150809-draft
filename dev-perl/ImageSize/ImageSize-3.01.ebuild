# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageSize/ImageSize-3.01.ebuild,v 1.1 2006/09/30 12:34:25 ian Exp $

inherit perl-module

MY_P=Image-Size-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="The Perl Image-Size Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Image/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/R/RJ/RJRAY/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="test"
SRC_TEST="do"
mydoc="ToDo"

DEPEND="dev-lang/perl
	test? ( dev-perl/Test-Pod-Coverage )"
RDEPEND="${DEPEND}"
