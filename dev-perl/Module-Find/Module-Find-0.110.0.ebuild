# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Find/Module-Find-0.110.0.ebuild,v 1.2 2012/09/01 11:40:18 grobian Exp $

EAPI=4

MODULE_AUTHOR=CRENZ
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="Find and use installed modules in a (sub)category"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-aix ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
