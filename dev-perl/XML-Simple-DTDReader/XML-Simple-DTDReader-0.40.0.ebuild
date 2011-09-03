# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Simple-DTDReader/XML-Simple-DTDReader-0.40.0.ebuild,v 1.2 2011/09/03 21:04:36 tove Exp $

EAPI=4

MODULE_AUTHOR=ALEXMV
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="Simple XML file reading based on their DTDs"

SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-perl/XML-Parser-2.34"
RDEPEND="${DEPEND}"

SRC_TEST=do
