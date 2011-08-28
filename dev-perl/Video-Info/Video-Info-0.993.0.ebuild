# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Video-Info/Video-Info-0.993.0.ebuild,v 1.1 2011/08/28 09:13:47 tove Exp $

EAPI=4

MODULE_AUTHOR=ALLENDAY
MODULE_VERSION=0.993
inherit perl-module

DESCRIPTION="Perl extension for getting video info"

LICENSE="Aladdin"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/Class-MakeMethods"
RDEPEND="${DEPEND}"
