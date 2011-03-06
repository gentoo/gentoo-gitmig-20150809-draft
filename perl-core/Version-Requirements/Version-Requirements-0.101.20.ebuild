# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Version-Requirements/Version-Requirements-0.101.20.ebuild,v 1.1 2011/03/06 07:26:22 tove Exp $

EAPI=3

MODULE_AUTHOR=RJBS
MODULE_VERSION=0.101020
inherit perl-module

DESCRIPTION="A set of version requirements for a CPAN dist"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	virtual/perl-Scalar-List-Utils
	>=virtual/perl-version-0.77
"
DEPEND="${RDEPEND}"

SRC_TEST="do"
