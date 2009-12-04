# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Time-HiRes/Time-HiRes-1.97.19.ebuild,v 1.2 2009/12/04 12:39:31 fauli Exp $

inherit versionator
MODULE_AUTHOR=JHI
MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Perl Time::HiRes. High resolution alarm, sleep, gettimeofday, interval timers"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

mydoc="TODO"

SRC_TEST="do"
