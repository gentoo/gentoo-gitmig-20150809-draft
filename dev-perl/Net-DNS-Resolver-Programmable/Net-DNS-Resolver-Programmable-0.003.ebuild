# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DNS-Resolver-Programmable/Net-DNS-Resolver-Programmable-0.003.ebuild,v 1.2 2009/06/10 01:41:45 robbat2 Exp $

MODULE_AUTHOR="JMEHNLE"
MODULE_SECTION="net-dns-resolver-programmable"
MY_P="${PN}-v${PV}"
S="${WORKDIR}/${MY_P}"

inherit perl-module

DESCRIPTION="programmable DNS resolver class for offline emulation of DNS"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-perl/Net-DNS"
DEPEND="${RDEPEND}
		>=virtual/perl-Module-Build-0.33"

SRC_TEST="do"
mydoc="TODO"
