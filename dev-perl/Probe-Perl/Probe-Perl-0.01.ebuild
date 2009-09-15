# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Probe-Perl/Probe-Perl-0.01.ebuild,v 1.1 2009/09/15 07:41:45 tove Exp $

EAPI=2

MODULE_AUTHOR=KWILLIAMS
inherit perl-module

DESCRIPTION="Information about the currently running perl"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=do
