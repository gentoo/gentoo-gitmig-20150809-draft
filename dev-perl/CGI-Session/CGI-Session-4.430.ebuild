# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-Session/CGI-Session-4.430.ebuild,v 1.1 2011/01/13 12:45:24 tove Exp $

EAPI=3

MODULE_AUTHOR=MARKSTOS
MODULE_VERSION=4.43
inherit perl-module

DESCRIPTION="persistent session data in CGI applications "

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND="virtual/perl-Digest-MD5
	virtual/perl-Scalar-List-Utils
	>=virtual/perl-CGI-3.26"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( virtual/perl-Test-Simple
		dev-perl/Cgi-Simple
		dev-perl/Test-Pod )"

SRC_TEST="do"
