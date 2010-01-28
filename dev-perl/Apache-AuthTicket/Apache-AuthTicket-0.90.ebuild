# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-AuthTicket/Apache-AuthTicket-0.90.ebuild,v 1.2 2010/01/28 18:24:01 tove Exp $

MODULE_AUTHOR=MSCHOUT
inherit perl-module

DESCRIPTION="Cookie based access module."

LICENSE="|| ( Artistic-2 GPL-1 GPL-2 GPL-3 )" # GPL-1+
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/Apache-AuthCookie-3.0
	dev-perl/DBI
	virtual/perl-Digest-MD5
	dev-perl/SQL-Abstract
	dev-lang/perl"

SRC_TEST="do"
