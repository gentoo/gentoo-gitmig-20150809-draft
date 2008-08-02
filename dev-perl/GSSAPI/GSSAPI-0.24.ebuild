# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GSSAPI/GSSAPI-0.24.ebuild,v 1.14 2008/08/02 20:25:30 tove Exp $

MODULE_AUTHOR=AGROLMS
inherit perl-module

DESCRIPTION="GSSAPI - Perl extension providing access to the GSSAPIv2 library"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="test"
SRC_TEST="do"

RDEPEND="dev-lang/perl
	virtual/krb5"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"
