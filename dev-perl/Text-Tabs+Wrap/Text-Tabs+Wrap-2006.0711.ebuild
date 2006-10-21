# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Tabs+Wrap/Text-Tabs+Wrap-2006.0711.ebuild,v 1.5 2006/10/21 14:46:05 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Expand/unexpand tabs per unix expand and line wrapping"
SRC_URI="mirror://cpan/authors/id/M/MU/MUIR/modules/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Text/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha amd64 ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
SRC_TEST="do"


DEPEND="dev-lang/perl"
