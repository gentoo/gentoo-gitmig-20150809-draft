# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/CPAN-Meta/CPAN-Meta-2.110.440.ebuild,v 1.1 2011/03/06 07:30:37 tove Exp $

EAPI=3

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=2.110440
inherit perl-module

DESCRIPTION="The distribution metadata for a CPAN dist"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=virtual/perl-Parse-CPAN-Meta-1.440
	virtual/perl-Scalar-List-Utils
	virtual/perl-Storable
	>=virtual/perl-Version-Requirements-0.101.20
	>=virtual/perl-version-0.82"
DEPEND="${RDEPEND}
	virtual/perl-File-Spec
	>=virtual/perl-File-Temp-0.20
	virtual/perl-IO
	>=virtual/perl-Parse-CPAN-Meta-1.440
	>=virtual/perl-Test-Simple-0.96
	>=virtual/perl-ExtUtils-MakeMaker-6.56"

SRC_TEST="do"
