# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PPI/PPI-1.203.ebuild,v 1.3 2009/05/31 16:16:49 maekke Exp $

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Parse, Analyze and Manipulate Perl (without perl)"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="test"

SRC_TEST="do"

RDEPEND="
	>=virtual/perl-Scalar-List-Utils-1.19
	>=dev-perl/Params-Util-0.10
	>=dev-perl/Clone-0.25
	virtual/perl-Digest-MD5
	dev-perl/IO-String
	>=dev-perl/List-MoreUtils-0.16
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( >=dev-perl/File-Remove-0.39
		virtual/perl-File-Spec
		dev-perl/Test-SubCalls
		dev-perl/Test-Object
		dev-perl/Test-ClassAPI )"
