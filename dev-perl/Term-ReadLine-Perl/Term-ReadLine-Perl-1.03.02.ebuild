# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ReadLine-Perl/Term-ReadLine-Perl-1.03.02.ebuild,v 1.10 2009/05/08 18:16:11 tove Exp $

inherit versionator
MODULE_AUTHOR=ILYAZ
MODULE_SECTION=modules
MY_P="${PN}-$(delete_version_separator 2)"
S="${WORKDIR}/${MY_P}"
inherit perl-module

DESCRIPTION="Quick implementation of readline utilities."

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
