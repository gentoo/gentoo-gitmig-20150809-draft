# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Locale/DateTime-Locale-0.45.ebuild,v 1.4 2010/06/27 19:04:56 nixnut Exp $

EAPI=2

inherit versionator
MY_P=${PN}-$(delete_version_separator 2)
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=DROLSKY
inherit perl-module

DESCRIPTION="Localization support for DateTime"

LICENSE="|| ( Artistic GPL-2 ) unicode"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=">=dev-perl/Params-Validate-0.91
	dev-perl/List-MoreUtils"
DEPEND=">=virtual/perl-Module-Build-0.35
	${RDEPEND}"

SRC_TEST="do"
