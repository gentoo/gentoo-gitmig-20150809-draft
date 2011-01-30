# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/CPAN-Meta-YAML/CPAN-Meta-YAML-0.3.ebuild,v 1.3 2011/01/30 18:14:59 armin76 Exp $

EAPI=3

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=0.003
inherit perl-module

DESCRIPTION="Read and write a subset of YAML for CPAN Meta files"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~s390 ~sh ~sparc ~x86"
IUSE=""

SRC_TEST="do"
