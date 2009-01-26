# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-MessageID/Email-MessageID-1.40.1.ebuild,v 1.1 2009/01/26 11:22:27 tove Exp $

inherit versionator
MODULE_AUTHOR=RJBS
MY_P="${PN}-$(delete_version_separator 2)"
inherit perl-module

DESCRIPTION="Generate world unique message-ids"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/Email-Address
	dev-lang/perl"

SRC_TEST="do"
S=${WORKDIR}/${MY_P}
