# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Moose/Moose-0.75.ebuild,v 1.1 2009/04/21 16:43:43 tove Exp $

EAPI=2

MODULE_AUTHOR=DROLSKY
inherit perl-module

DESCRIPTION="A postmodern object system for Perl 5"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Data-OptList
	>=virtual/perl-Scalar-List-Utils-1.19
	>=dev-perl/Class-MOP-0.81
	>=dev-perl/List-MoreUtils-0.12
	>=dev-perl/Sub-Exporter-0.972
	dev-perl/Task-Weaken"
DEPEND="${RDEPEND}
	test? ( >=virtual/perl-Test-Simple-0.77
		>=dev-perl/Test-Exception-0.21
		dev-perl/Test-LongString
		>=dev-perl/Test-Warn-0.11
		dev-perl/Test-Deep
		dev-perl/Module-Refresh )"

SRC_TEST=do
