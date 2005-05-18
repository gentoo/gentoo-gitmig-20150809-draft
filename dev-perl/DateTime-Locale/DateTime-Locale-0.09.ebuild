# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Locale/DateTime-Locale-0.09.ebuild,v 1.11 2005/05/18 10:49:17 corsair Exp $

inherit perl-module

DESCRIPTION="Localization support for DateTime"
HOMEPAGE="http://search.cpan.org/~drolsky/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc ~alpha ~amd64 ppc64"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/module-build
		dev-perl/Params-Validate"
