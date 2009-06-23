# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Declare/Devel-Declare-0.005006.ebuild,v 1.1 2009/06/23 20:57:33 tove Exp $

EAPI=2

MODULE_AUTHOR="FLORA"
inherit perl-module

DESCRIPTION="Adding keywords to perl, in perl"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Sub-Name
	virtual/perl-Scalar-List-Utils
	dev-perl/B-Hooks-OP-Check
	dev-perl/B-Hooks-EndOfScope"
DEPEND="${RDEPEND}
	dev-perl/extutils-depends"

SRC_TEST=do
