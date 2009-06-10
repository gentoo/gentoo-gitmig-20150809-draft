# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-IMAPClient/Mail-IMAPClient-3.18.ebuild,v 1.1 2009/06/10 01:49:30 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=PLOBBES
inherit perl-module eutils

DESCRIPTION="IMAP client module for Perl"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="test"

RDEPEND=">=virtual/perl-libnet-1.0703
	>=dev-perl/Parse-RecDescent-1.94"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"
#		>=virtual/perl-File-Temp-0.18 )"
		# only used in t/basic.t

SRC_TEST="do"

mydoc="FAQ"
