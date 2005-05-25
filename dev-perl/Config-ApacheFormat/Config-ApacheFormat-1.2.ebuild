# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-ApacheFormat/Config-ApacheFormat-1.2.ebuild,v 1.3 2005/05/25 15:19:01 mcummings Exp $

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
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"

SRC_TEST="do"

DEPEND="${DEPEND}
		dev-perl/Class-MethodMaker
		perl-core/Text-Balanced
		perl-core/File-Spec"
