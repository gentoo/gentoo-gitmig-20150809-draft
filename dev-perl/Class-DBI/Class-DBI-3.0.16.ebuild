# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-DBI/Class-DBI-3.0.16.ebuild,v 1.9 2011/12/11 15:19:34 armin76 Exp $

MODULE_AUTHOR=TMTM
MY_P="${PN}-v${PV}"
S="${WORKDIR}/${MY_P}"

inherit perl-module

DESCRIPTION="Simple Database Abstraction"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE=""

# Tests aren't possible since they require interaction with the DB's

DEPEND=">=dev-perl/Class-Data-Inheritable-0.02
		>=dev-perl/Class-Accessor-0.18
		>=dev-perl/Class-Trigger-0.07
		virtual/perl-File-Temp
		virtual/perl-Storable
		virtual/perl-Test-Simple
		virtual/perl-Scalar-List-Utils
		dev-perl/Clone
		>=dev-perl/Ima-DBI-0.33
		virtual/perl-version
		>=dev-perl/UNIVERSAL-moniker-0.06
	dev-lang/perl"
