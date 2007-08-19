# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GSSAPI/GSSAPI-0.24.ebuild,v 1.1 2007/08/19 09:58:42 ian Exp $

inherit perl-module

DESCRIPTION="GSSAPI - Perl extension providing access to the GSSAPIv2 library"
HOMEPAGE="http://search.cpan.org/~agrolms/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AG/AGROLMS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86"
IUSE="test"
SRC_TEST="do"

DEPEND="dev-lang/perl
		app-crypt/mit-krb5
		test? ( perl-core/Test-Simple )"
