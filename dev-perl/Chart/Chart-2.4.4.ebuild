# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Chart/Chart-2.4.4.ebuild,v 1.2 2012/02/12 18:01:54 armin76 Exp $

EAPI=4

MODULE_AUTHOR=CHARTGRP
MODULE_VERSION=2.4.4
inherit perl-module

DESCRIPTION="The Perl Chart Module"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="test"

RDEPEND=">=dev-perl/GD-2.0.36"
DEPEND="${RDEPEND}
	test? (
		dev-perl/GD[png]
	)
"

SRC_TEST="do"
