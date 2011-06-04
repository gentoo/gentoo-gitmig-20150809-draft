# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-EncWords/MIME-EncWords-1.12.3.ebuild,v 1.1 2011/06/04 07:05:40 tove Exp $

EAPI=4

MODULE_AUTHOR=NEZUMI
MODULE_VERSION=1.012.3
inherit perl-module

DESCRIPTION="Deal with RFC 2047 encoded words (improved)"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/perl-MIME-Base64
	virtual/perl-Encode
	dev-perl/MIME-Charset"
RDEPEND="${DEPEND}"

SRC_TEST="do"
