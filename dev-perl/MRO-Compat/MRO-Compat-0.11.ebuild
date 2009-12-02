# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MRO-Compat/MRO-Compat-0.11.ebuild,v 1.3 2009/12/02 09:25:18 tove Exp $

EAPI=2

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Lets you build groups of accessors"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="test"

RDEPEND="
	>=dev-perl/Class-C3-0.20"
#	>=dev-perl/Class-C3-XS-0.08"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
