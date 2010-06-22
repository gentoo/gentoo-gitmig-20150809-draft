# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Capture-Tiny/Capture-Tiny-0.08.ebuild,v 1.1 2010/06/22 15:35:36 tove Exp $

EAPI=2

MODULE_AUTHOR=DAGOLDEN
inherit perl-module

DESCRIPTION="Capture STDOUT and STDERR from Perl, XS or external programs"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="virtual/perl-Module-Build"

SRC_TEST=do
