# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-IMAPClient/Mail-IMAPClient-3.10.ebuild,v 1.1 2008/08/26 08:18:46 tove Exp $

MODULE_AUTHOR=MARKOV
inherit perl-module eutils

DESCRIPTION="IMAP client module for Perl"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=virtual/perl-libnet-1.0703
	>=dev-perl/Parse-RecDescent-1.94
	dev-perl/Digest-HMAC
	dev-lang/perl"
#	>=virtual/perl-File-Temp-0.18"

SRC_TEST="do"

mydoc="FAQ"
