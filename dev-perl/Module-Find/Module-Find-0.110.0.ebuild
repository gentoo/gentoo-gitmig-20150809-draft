# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Find/Module-Find-0.110.0.ebuild,v 1.1 2012/05/23 18:19:10 tove Exp $

EAPI=4

MODULE_AUTHOR=CRENZ
MODULE_VERSION=0.11
inherit perl-module

DESCRIPTION="Find and use installed modules in a (sub)category"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
