# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Array-Window/Array-Window-0.1.ebuild,v 1.4 2004/06/25 00:06:44 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Array::Window - Calculate windows/subsets/pages of arrays"
SRC_URI="http://www.cpan.org/modules/by-module/Array/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Array/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="x86 amd64 ~sparc"

DEPEND="${DEPEND}
	dev-perl/Test-Simple
	dev-perl/Class-Inspector"
