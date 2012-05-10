# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WebService-MusicBrainz/WebService-MusicBrainz-0.93.ebuild,v 1.1 2012/05/10 06:52:16 ssuominen Exp $

EAPI=4

MODULE_AUTHOR=BFAIST
inherit perl-module

DESCRIPTION="Web service API to MusicBrainz database"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Class-Accessor
	dev-perl/libwww-perl
	dev-perl/URI
	dev-perl/XML-LibXML"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	virtual/perl-Module-Build
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
