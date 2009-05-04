# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-Cache-Transparent/HTTP-Cache-Transparent-1.0.ebuild,v 1.5 2009/05/04 16:12:45 armin76 Exp $

MODULE_AUTHOR=MATTIASH
inherit perl-module

DESCRIPTION="Cache the result of http get-requests persistently"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE="test"

SRC_TEST="do"

RDEPEND="dev-perl/libwww-perl
	virtual/perl-Digest-MD5
	virtual/perl-Storable
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"
