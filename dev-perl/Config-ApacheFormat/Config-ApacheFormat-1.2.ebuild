# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-ApacheFormat/Config-ApacheFormat-1.2.ebuild,v 1.4 2005/08/25 22:41:31 agriffis Exp $

inherit perl-module
MY_PV=${PV/0/}
MY_P=${PN}-${MY_PV}
IUSE=""

S=${WORKDIR}/${MY_P}
DESCRIPTION="use Apache format config files"
SRC_URI="mirror://cpan/authors/id/S/SA/SAMTREGAR/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~samtregar/${MY_P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

SRC_TEST="do"

DEPEND="${DEPEND}
		dev-perl/Class-MethodMaker
		perl-core/Text-Balanced
		perl-core/File-Spec"
