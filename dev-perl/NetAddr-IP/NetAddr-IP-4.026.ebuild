# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/NetAddr-IP/NetAddr-IP-4.026.ebuild,v 1.2 2009/06/10 01:42:02 robbat2 Exp $

MODULE_AUTHOR="MIKER"

inherit perl-module

DESCRIPTION="Manipulation and operations on IP addresses"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

SRC_TEST="do"
mydoc="TODO"
