# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Type/File-Type-0.22.ebuild,v 1.4 2005/04/09 01:29:48 gustavoz Exp $

inherit perl-module

DESCRIPTION="determine file type using magic "
SRC_URI="mirror://cpan/authors/id/P/PM/PMISON/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/File/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/module-build"
