# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Flat/File-Flat-0.91.ebuild,v 1.4 2004/10/16 23:57:21 rac Exp $

inherit perl-module

DESCRIPTION="Implements a flat filesystem"
SRC_URI="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~alpha ~ppc ~sparc"
IUSE=""

DEPEND=">=dev-perl/Class-Autouse-1*
	dev-perl/File-Spec
	dev-perl/File-Temp
	dev-perl/File-NCopy
	dev-perl/File-Remove
	dev-perl/Class-Inspector"
