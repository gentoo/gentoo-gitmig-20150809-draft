# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Locale/DateTime-Locale-0.09.ebuild,v 1.6 2004/09/22 13:26:17 gustavoz Exp $

inherit perl-module

DESCRIPTION="Localization support for DateTime"
HOMEPAGE="http://search.cpan.org/~drolsky/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/D/DR/DROLSKY/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"
IUSE=""
SRC_TEST="do"

style="builder"

DEPEND="dev-perl/module-build
		dev-perl/Params-Validate"
