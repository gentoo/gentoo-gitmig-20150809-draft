# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-Session/CGI-Session-4.41.ebuild,v 1.4 2009/05/03 18:16:29 tcunha Exp $

EAPI=2

MODULE_AUTHOR=MARKSTOS
inherit perl-module

DESCRIPTION="persistent session data in CGI applications "

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc sparc x86"
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
