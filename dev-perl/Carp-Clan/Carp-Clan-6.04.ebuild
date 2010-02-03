# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Carp-Clan/Carp-Clan-6.04.ebuild,v 1.3 2010/02/03 11:26:19 aballier Exp $

EAPI=2

MODULE_AUTHOR=STBEY
inherit perl-module

DESCRIPTION="Report errors from perspective of caller of a clan of modules"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Exception )"

SRC_TEST="do"
