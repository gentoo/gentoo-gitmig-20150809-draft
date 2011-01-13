# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-Load-Conditional/Module-Load-Conditional-0.400.ebuild,v 1.1 2011/01/13 08:27:41 tove Exp $

EAPI=3

MODULE_AUTHOR=BINGOS
MODULE_VERSION=0.40
inherit perl-module

DESCRIPTION="Looking up module information / loading at runtime"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=virtual/perl-Module-Load-0.12
	>=virtual/perl-Module-CoreList-0.22
	virtual/perl-Locale-Maketext-Simple
	virtual/perl-Params-Check
	virtual/perl-version"
RDEPEND="${DEPEND}"

SRC_TEST=do
