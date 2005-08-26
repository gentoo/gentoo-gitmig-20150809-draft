# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/text-reform/text-reform-1.11.ebuild,v 1.14 2005/08/26 01:20:39 agriffis Exp $

inherit perl-module

MY_P=Text-Reform-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Manual text wrapping and reformatting"
SRC_URI="mirror://cpan/authors/id/D/DC/DCONWAY/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Text/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~hppa ~ia64 ppc ppc64 s390 sparc x86"
IUSE=""
