# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GSSAPI/GSSAPI-0.24.ebuild,v 1.17 2009/11/03 17:14:34 armin76 Exp $

MODULE_AUTHOR=AGROLMS
inherit perl-module

DESCRIPTION="GSSAPI - Perl extension providing access to the GSSAPIv2 library"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86"
IUSE="test"
SRC_TEST="do"

RDEPEND="dev-lang/perl
	virtual/krb5"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"
