# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GSSAPI/GSSAPI-0.26.ebuild,v 1.1 2008/12/31 18:27:59 tove Exp $

MODULE_AUTHOR=AGROLMS
inherit perl-module

DESCRIPTION="GSSAPI - Perl extension providing access to the GSSAPIv2 library"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="test"

RDEPEND="dev-lang/perl
	virtual/krb5"
DEPEND="${RDEPEND}
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
