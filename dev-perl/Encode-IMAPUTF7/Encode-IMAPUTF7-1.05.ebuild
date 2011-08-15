# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Encode-IMAPUTF7/Encode-IMAPUTF7-1.05.ebuild,v 1.1 2011/08/15 14:10:26 patrick Exp $

EAPI=3

MODULE_AUTHOR="PMAKHOLM"
inherit perl-module

DESCRIPTION="Modification of UTF-7 encoding for IMAP"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="virtual/perl-Encode"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-NoWarnings )"

SRC_TEST="do"
