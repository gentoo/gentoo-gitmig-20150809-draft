# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Cracklib/Crypt-Cracklib-1.4-r1.ebuild,v 1.1 2008/07/30 07:21:04 tove Exp $

MODULE_AUTHOR="DANIEL"
inherit perl-module

DESCRIPTION="Perl interface to Alec Muffett's Cracklib"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="test"
SRC_TEST="do"

RDEPEND="sys-libs/cracklib
		dev-lang/perl"
DEPEND="${RDEPEND}
		test? ( dev-perl/Pod-Coverage
				dev-perl/Test-Pod-Coverage )"
