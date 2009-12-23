# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-W3CDTF/DateTime-Format-W3CDTF-0.05.ebuild,v 1.2 2009/12/23 18:04:21 grobian Exp $

MODULE_AUTHOR=DROLSKY
inherit perl-module

DESCRIPTION="Parse and format W3CDTF datetime strings"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-solaris"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/DateTime
		dev-lang/perl"
