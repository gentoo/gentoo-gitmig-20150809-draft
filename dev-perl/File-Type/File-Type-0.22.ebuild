# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Type/File-Type-0.22.ebuild,v 1.8 2006/02/22 22:35:35 agriffis Exp $

inherit perl-module

DESCRIPTION="determine file type using magic "
SRC_URI="mirror://cpan/authors/id/P/PM/PMISON/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/module-build"
