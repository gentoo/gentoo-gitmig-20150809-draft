# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Random-ISAAC/Math-Random-ISAAC-1.3.ebuild,v 1.1 2011/01/25 09:59:51 tove Exp $

EAPI=3

MODULE_AUTHOR=JAWNSY
MODULE_VERSION=1.003
inherit perl-module

DESCRIPTION="Perl interface to the ISAAC PRNG algorithm"

LICENSE="|| ( public-domain MIT Artistic Artistic-2 GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-NoWarnings
	)"

SRC_TEST="do"
