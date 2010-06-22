# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-OAuth/Net-OAuth-0.27.ebuild,v 1.1 2010/06/22 06:31:58 tove Exp $

EAPI=2

MODULE_AUTHOR=KGRENNAN
inherit perl-module

DESCRIPTION="OAuth protocol support"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Class-Accessor-0.31
	>=dev-perl/Class-Data-Inheritable-0.06
	dev-perl/Digest-HMAC
	dev-perl/URI
	>=virtual/perl-Encode-2.35"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( >=virtual/perl-Test-Simple-0.66
		>=dev-perl/Test-Warn-0.21 )"

SRC_TEST=do
