# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Accessor-Chained/Class-Accessor-Chained-0.10.ebuild,v 1.5 2011/04/24 15:47:40 grobian Exp $

EAPI=3

MODULE_VERSION=0.01
MODULE_AUTHOR=RCLAMP
inherit perl-module

DESCRIPTION="Perl module to make chained class accessors"

SLOT="0"
KEYWORDS="amd64 x86 ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/Class-Accessor"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
