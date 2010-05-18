# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Portability-Files/Test-Portability-Files-0.05.ebuild,v 1.2 2010/05/18 06:55:22 tove Exp $

EAPI=2

MODULE_AUTHOR=SAPER
inherit perl-module

DESCRIPTION="Check file names portability"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/perl-File-Spec
	virtual/perl-Test-Simple"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
