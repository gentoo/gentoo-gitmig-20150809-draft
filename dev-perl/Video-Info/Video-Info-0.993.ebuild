# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Video-Info/Video-Info-0.993.ebuild,v 1.8 2009/02/07 12:36:36 tove Exp $

MODULE_AUTHOR=ALLENDAY
inherit perl-module

DESCRIPTION="Perl extension for getting video info"

LICENSE="Aladdin"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/Class-MakeMethods"
RDEPEND="${DEPEND}"
