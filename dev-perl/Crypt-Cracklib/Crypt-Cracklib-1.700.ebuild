# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Cracklib/Crypt-Cracklib-1.700.ebuild,v 1.1 2011/01/12 22:02:53 tove Exp $

EAPI=3

MODULE_AUTHOR=DANIEL
MODULE_VERSION=1.7
inherit perl-module

DESCRIPTION="Perl interface to Alec Muffett's Cracklib"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="test"

RDEPEND="sys-libs/cracklib"
DEPEND="${RDEPEND}
	test? ( dev-perl/Pod-Coverage
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
