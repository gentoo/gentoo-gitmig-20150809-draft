# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Encode-Detect/Encode-Detect-1.01.ebuild,v 1.4 2010/01/09 19:52:32 grobian Exp $

MODULE_AUTHOR=JGMYERS
inherit perl-module

DESCRIPTION="Encode::Detect - An Encode::Encoding subclass that detects the encoding of data"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="virtual/perl-Module-Build
	virtual/perl-ExtUtils-CBuilder"

SRC_TEST=do
