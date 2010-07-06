# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DNS-Resolver-Programmable/Net-DNS-Resolver-Programmable-0.003.ebuild,v 1.9 2010/07/06 20:54:03 ssuominen Exp $

EAPI=2

MODULE_AUTHOR="JMEHNLE"
MODULE_SECTION="net-dns-resolver-programmable"
MY_P="${PN}-v${PV}"
S="${WORKDIR}/${MY_P}"

inherit perl-module

DESCRIPTION="programmable DNS resolver class for offline emulation of DNS"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~ppc64 sparc x86"
IUSE=""

RDEPEND="dev-perl/Net-DNS
	virtual/perl-version"
DEPEND="${RDEPEND}
		>=virtual/perl-Module-Build-0.33"

SRC_TEST="do"
mydoc="TODO"
