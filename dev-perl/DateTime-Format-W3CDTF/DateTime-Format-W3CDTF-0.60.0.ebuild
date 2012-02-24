# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-W3CDTF/DateTime-Format-W3CDTF-0.60.0.ebuild,v 1.2 2012/02/24 10:04:57 ago Exp $

EAPI=4

MODULE_AUTHOR=GWILLIAMS
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Parse and format W3CDTF datetime strings"

SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/DateTime"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
