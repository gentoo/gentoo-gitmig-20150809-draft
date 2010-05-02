# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Inter/Test-Inter-1.01.ebuild,v 1.2 2010/05/02 22:13:02 mr_bones_ Exp $

EAPI="2"

MODULE_AUTHOR="SBECK"

inherit perl-module

DESCRIPTION="framework for more readable interactive test scripts"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Test-Pod-Coverage
	dev-perl/Test-Pod
	dev-lang/perl"

SRC_TEST="do"
