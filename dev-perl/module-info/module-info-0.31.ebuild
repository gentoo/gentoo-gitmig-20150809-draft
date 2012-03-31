# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/module-info/module-info-0.31.ebuild,v 1.12 2012/03/31 17:05:24 armin76 Exp $

EAPI=2

MODULE_AUTHOR=MBARBON
MY_PN=Module-Info
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

inherit perl-module

DESCRIPTION="Information about Perl modules"

SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc ppc64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
