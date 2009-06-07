# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Send/Email-Send-2.195.ebuild,v 1.1 2009/06/07 12:20:45 tove Exp $

EAPI=2

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Simply Sending Email"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/perl-Test-Simple
	>=virtual/perl-Module-Pluggable-2.97
	virtual/perl-Scalar-List-Utils
	>=dev-perl/Return-Value-1.302
	virtual/perl-File-Spec
	dev-perl/Email-Simple
	dev-perl/Email-Address"
RDEPEND="${DEPEND}"

SRC_TEST="do"
