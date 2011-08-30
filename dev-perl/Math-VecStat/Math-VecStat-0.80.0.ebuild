# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-VecStat/Math-VecStat-0.80.0.ebuild,v 1.1 2011/08/30 10:17:26 tove Exp $

EAPI=4

MODULE_AUTHOR=ASPINELLI
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="Some basic numeric stats on vectors"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86 ~x86-solaris"
IUSE=""

SRC_TEST="do"
