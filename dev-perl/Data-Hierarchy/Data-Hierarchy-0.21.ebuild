# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Hierarchy/Data-Hierarchy-0.21.ebuild,v 1.3 2005/02/05 14:18:38 absinthe Exp $

inherit perl-module

DESCRIPTION="Data::Hierarchy - Handle data in a hierarchical structure"
SRC_URI="http://www.cpan.org/modules/by-module/Data/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Data/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	dev-perl/Clone"
