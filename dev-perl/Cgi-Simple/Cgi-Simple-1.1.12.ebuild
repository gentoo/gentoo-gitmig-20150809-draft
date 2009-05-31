# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cgi-Simple/Cgi-Simple-1.1.12.ebuild,v 1.1 2009/05/31 18:10:46 tove Exp $

EAPI=2

inherit versionator
MY_PN=CGI-Simple
MY_P=${MY_PN}-$(delete_version_separator 2)
MODULE_AUTHOR=ANDYA
inherit perl-module

DESCRIPTION="A Simple totally OO CGI interface that is CGI.pm compliant"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="virtual/perl-Module-Build
	test? ( dev-perl/libwww-perl
		dev-perl/IO-stringy
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

S=${WORKDIR}/${MY_P}

SRC_TEST="do"
