# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IP-Country/IP-Country-2.26.ebuild,v 1.1 2009/01/13 19:52:56 robbat2 Exp $

MODULE_AUTHOR="NWETTERS"
inherit perl-module

DESCRIPTION="fast lookup of country codes from IP addresses"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Geography-Countries
	dev-lang/perl"
mydoc="TODO"
