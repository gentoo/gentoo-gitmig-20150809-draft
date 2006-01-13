# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Type/File-Type-0.22.ebuild,v 1.7 2006/01/13 20:50:31 mcummings Exp $

inherit perl-module

DESCRIPTION="determine file type using magic "
SRC_URI="mirror://cpan/authors/id/P/PM/PMISON/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~hppa ~ppc sparc x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/module-build"
