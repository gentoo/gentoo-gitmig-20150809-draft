# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Twitter/Net-Twitter-3.10001.ebuild,v 1.1 2009/11/28 02:02:26 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=MMIMS
inherit perl-module

DESCRIPTION="A perl interface to the Twitter API"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Moose
	dev-perl/Data-Visitor
	>=dev-perl/DateTime-0.50
	dev-perl/DateTime-Format-Strptime
	virtual/perl-Digest-SHA
	dev-perl/HTML-Parser
	dev-perl/libwww-perl
	dev-perl/JSON-Any
	dev-perl/JSON-XS
	virtual/perl-Scalar-List-Utils
	dev-perl/MooseX-AttributeHelpers
	dev-perl/MooseX-MultiInitArg
	dev-perl/Net-OAuth
	dev-perl/namespace-autoclean"
DEPEND="${RDEPEND}"

# online test
SRC_TEST=skip
