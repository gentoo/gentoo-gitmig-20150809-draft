# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Array-Window/Array-Window-0.1.ebuild,v 1.6 2005/01/13 02:08:55 gustavoz Exp $

inherit perl-module

DESCRIPTION="Array::Window - Calculate windows/subsets/pages of arrays"
SRC_URI="http://www.cpan.org/modules/by-module/Array/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Array/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="x86 amd64 sparc"

DEPEND="${DEPEND}
	dev-perl/Test-Simple
	dev-perl/Class-Inspector"
