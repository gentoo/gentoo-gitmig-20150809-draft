# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-Statistics-Linux/Sys-Statistics-Linux-0.50.ebuild,v 1.1 2009/05/19 18:34:13 tove Exp $

EAPI=2

MODULE_AUTHOR=BLOONIX
inherit perl-module

DESCRIPTION="Collect linux system statistics"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="test"

RDEPEND="dev-perl/YAML-Syck"
DEPEND="
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
