# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-POP3Client/Mail-POP3Client-2.18.ebuild,v 1.1 2008/10/22 09:31:05 tove Exp $

MODULE_AUTHOR=SDOWD
inherit perl-module

DESCRIPTION="POP3 client module for Perl"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"

mydoc="FAQ"
