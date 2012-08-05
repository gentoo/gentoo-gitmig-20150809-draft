# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Dist-CheckConflicts/Dist-CheckConflicts-0.20.0.ebuild,v 1.11 2012/08/05 16:41:23 maekke Exp $

EAPI=4

MODULE_AUTHOR=DOY
MODULE_VERSION=0.02
inherit perl-module

DESCRIPTION="Declare version conflicts for your dist"

SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ppc ~s390 ~sh ~sparc x86 ~x86-fbsd ~x86-freebsd ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/Sub-Exporter
	>=dev-perl/List-MoreUtils-0.12"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Fatal
		>=virtual/perl-Test-Simple-0.88
	)"

SRC_TEST="do"
